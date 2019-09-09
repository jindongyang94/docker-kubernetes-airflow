import subprocess
import os
import re
import csv
import contextlib
from datetime import datetime, timedelta
import time
import progressbar

import boto3
import psycopg2

from modules.db_integration_to_s3.helper import RDSHelper, S3Helper, PGHelper, DATALAKE_NAME, logger, DATABASE_TAGS, INSTANCE_TAGS, TABLE_TAGS

"""
The idea of this script is to find the respective database instances using Boto3, and then find the 
respective databases in the instance and finally find the respective tables in each database and do a iterative
export and dump one table at a time to prevent overloading of memory.

This process can be expedited by parallel processing but I am unsure of how to do so yet. Would figure out a way
if this becomes a pertinent issue. 

Upload the file downloaded to s3 to the correct respective folders and buckets based on company
name. It is important to note that the files with the same name would be replaced. This would 
help in not saving redundant files but might not be useful if we want to version.

Since tables will never be able to be appended directly from s3, it does not make sense to load the entire csv all the time. 
Perhaps write another script to merge each csvs based on time periodically. 

S3 files would be named as follows: 
s3://{BucketName}/{InstanceName}/{DBName}/{TableName}/{TableName-TimeStamp}.csv

# This method allows me to connect to export csv files for each table.
# This method does not require the maintenance of a JSON file at all, just different AWS credentials
# needed for different servers if different users have different access to the databases.

"""
# List Individual DBs instance and their respective Database List -----------------------------------------------
def describe_all_instances():
    rds = RDSHelper()
    dbs = rds.describe_db_instances(filters=INSTANCE_TAGS)

    db_dictionary = {}

    for db in dbs:
            instance = db['DBInstanceIdentifier']
            dbuser = db['MasterUsername']
            endpoint = db['Endpoint']
            host = endpoint['Address']
            port = endpoint['Port']
            location = str(db['DBInstanceArn'].split(':')[3])

            logger.info("Accessing instance %s ..." % instance)

            pg = PGHelper(db='postgres', host=host, port=port, dbuser=dbuser)
            con = pg.conn()
            cur = con.cursor()

            def extract_name_query(title, qry):
                logger.info('%s' % (title))
                cur.execute(qry)
                results = cur.fetchall()
                result_names = list(map(lambda x: x[0], results))
                return result_names

            # List all available databases in the same instance
            database_names = extract_name_query(
                'Extracting databases...', 'SELECT * FROM pg_database')

            # Filtering available databases
            default_databases = ['postgres',
                                 'rdsadmin', 'template1', 'template0']
            database_names = list(
                filter(lambda x: x not in default_databases, database_names))
            if DATABASE_TAGS:
                database_names = list(
                    filter(lambda x: x in DATABASE_TAGS, database_names))

            # Save all the information based on key: DBInstance, value: [db, [list of databases extracted from the instance]]
            db_dictionary[instance] = [db, database_names]

    return db_dictionary

# Individual Company Database Migration -----------------------------------------------
def individual_company_migration(instance_details, database_name, table_filters):

    instance = instance_details['DBInstanceIdentifier']
    dbuser = instance_details['MasterUsername']
    endpoint = instance_details['Endpoint']
    host = endpoint['Address']
    port = endpoint['Port']
    location = str(instance_details['DBInstanceArn'].split(':')[3])

    pg = PGHelper(db='postgres', host=host, port=port, dbuser=dbuser)
    logger.info("Accessing %s ..." % database_name)
    con = pg.conn(database=database_name)
    cur = con.cursor()

    def extract_name_query(title, qry):
        logger.info('%s' % (title))
        cur.execute(qry)
        results = cur.fetchall()
        result_names = list(map(lambda x: x[0], results))
        return result_names

    # List all available tables in the same instance
    table_query = "SELECT table_name FROM information_schema.tables WHERE table_schema='public' AND table_type='BASE TABLE'"
    table_names = extract_name_query('Extracting tables...', table_query)

    # Filtering available tables
    if table_filters:
        table_names = list(
            filter(lambda x: x in table_names, table_names))
    # We should also filter away those tables that does not start with hubble as well: ['delayed_jobs', 'ar_internal_metadata', 'schema_migrations', 'audits']
    # We are going to remove hubble_safety_permit_logs as well as it is too big to be exported at the moment. 
    misc_tables = ['delayed_jobs', 'ar_internal_metadata', 'schema_migrations', 'audits', 'hubble_safety_permit_logs']
    table_names = list(
        filter(lambda x: x not in misc_tables, table_names)
    )
    logger.info("Tables List: %s" % table_names)
    
    # for table_name in table_names:
    for j in range(len(table_names)):
        table_name = table_names[j]

        # Rerun for the table when the exception fails
        while True:
            try:
                # Save individual tables to CSV first - as we are sending one table at a time, we can del the csv files
                # as soon as we have uploaded them
                logger.info("Accessing %s ..." % table_name)
                # We will save the time based on the latest commit time. Thus, there will be only one file for one table all time
                # However, they might be of different timestamp due to difference in commit time.
                
                s3 = S3Helper()
                # Extract latest timestamp separately here:
                # Use this query to extract the latest commit timestamp at that point of time
                extract_ts_query = "SELECT MAX(pg_xact_commit_timestamp(xmin)) FROM " + table_name + " WHERE pg_xact_commit_timestamp(xmin) IS NOT NULL;"
                cur.execute(extract_ts_query)
                latest_timestamp = str(cur.fetchone()[0])

                # Define needed timestamp to set the csvname we are using.
                if latest_timestamp and latest_timestamp != 'None':
                    logger.info ("Latest Commit Timestamp from PostGres is: %s" % latest_timestamp)
                    latest_csvtimestamp = s3._convert_s3timestamp(latest_timestamp)
                
                # However, if there is no timestamp at all, then use 24 '0's as the default. 
                else:
                    logger.info ("No Commit Timestamp available in PostGres. Using default.")
                    latest_csvtimestamp = '0' * 24
                
                csvname = table_name + "-" + latest_csvtimestamp + ".csv"
                local_csvname = database_name + "-" + csvname

                # Respective paths needed
                full_folder_path = ("%s/%s/%s/%s") % (DATALAKE_NAME, instance, database_name, table_name)
                full_table_path = "%s/%s/%s/%s/%s" % (DATALAKE_NAME, instance, database_name, table_name, csvname)
                s3_path = ("s3://%s") % (full_table_path)

                # Grab the latest_timestamp from the folder. Ideally, there should only be one file under each table folder, but
                # we will still segregate them as such for easy referencing.
                table_timestamp = s3.latest_s3timestamp(full_folder_path)

                # If we could not get a proper timestamp from s3, it means there is no initial file. 
                if not table_timestamp:
                    logger.info ("No CSV found in the respective S3 folder. Exporting all rows from table %s to csv." %  table_name)
                    local_csvpath = '/tmp/' + local_csvname
                    with open(local_csvpath, "w") as csvfile:
                        # Get all of the rows and export them
                        export_query = "COPY " + table_name + " TO STDOUT WITH CSV HEADER"
                        cur.copy_expert(export_query, csvfile)
                
                else:
                    logger.info ("CSV File found with Commit Timestamp: %s." % table_timestamp)
                    # Since the timestamp is down to the last milisecond, it is almost impossible for it be miss any rows.
                    # Thus, to save processing time, we share ignore any need to update the table csv if the timestamp is the same.
                    table_csvtimestamp = s3._convert_s3timestamp(table_timestamp) 
                    if table_csvtimestamp == latest_csvtimestamp:
                        logger.info ("The latest Commit Timestamp (%s) and the latest S3 Timestamp (%s) are the same. Proceeeding to next table."
                        % (latest_timestamp, table_timestamp))
                        logger.info('\n')
                        break

                    # If timestamp is 0000.. , we should just use the min datetime to prevent error.
                    if table_csvtimestamp == '0' * 24:
                        table_timestamp = datetime.min
                    
                    # Get only the rows after the committed timestamp retrieved and append that to the current csv.
                    # If there is no results, just go to the next table
                    export_query = "SELECT * FROM " + table_name + " WHERE pg_xact_commit_timestamp(xmin) > %s "
                    cur.execute(export_query, (table_timestamp,))
                    results = cur.fetchall()
                    if not results:
                        logger.info ("No new rows or updates from the current Database.")
                        logger.info('\n')
                        break

                    # Download the file to local storage first, then utilizing it - always save it under /tmp/ directory
                    # The file will also be deleted from s3
                    local_csvpath = s3.download_latest(full_folder_path)
                    with open(local_csvpath, 'a') as csvfile:
                        # Append by downloading the existing csv and append locally.
                        logger.info ("Writing rows into current local CSV File...")
                        for row in results:
                            writer = csv.writer(csvfile)
                            writer.writerow(row)
                    
                # Upload the file to the respective bucket - Replacing or uploading uses the same function
                # This way of uploading would not resetting the entire path, so it is fine to not add a check.
                s3.create_folder(full_folder_path, location)
                s3.upload(local_csvpath, full_table_path)
                latest_timestamp = s3._convert_timestamp(latest_csvtimestamp)
                logger.info ('FILE PUT AT: %s with Latest Committed Time (%s)' % (s3_path, latest_timestamp))

                # Deleting file from /tmp/ after use
                os.remove(local_csvpath)
                logger.info ('Local File Deleted: %s' % local_csvpath)
                logger.info('\n')
                break
            
            except psycopg2.Error as e:
                logger.error(e.pgerror)
                logger.info("Retrying for %s table." % table_name)
                logger.info('\n')
                continue
    return
            

# Full Program to Run Locally-----------------------------------------------
def full_database_migration(instance_filters=None, database_filters=None, table_filters=None):
    """
    -instance_filters (dict): for now it can be anything we are going to use to filter the instance: 
    1. db-cluster-id 2. db-instance-id
    A filter name and value pair that is used to return a more specific list of results from a describe operation. 
    Filters can be used to match a set of resources by specific criteria, such as IDs.
    The filters supported by a describe operation are documented with the describe operation.
    E.g. [{"Name" :"tag:keyname", "Values":[""] }] - Must explicitly specify "Names" and "Values" pair. 

    -database_filters (list): simply only append the database names to this list so we only access those databases. By default,
    it will access all

    -table_filters (list): simply only append table names to this list so we only export those tables. By default it will export all. 

    """
    # Initiate RDS instance helper to iterate through RDS
    rds = RDSHelper()
    dbs = rds.describe_db_instances(filters=instance_filters)

    logger.info ("Instances List: %s" % list(map(lambda x: x['DBInstanceIdentifier'], dbs)))

    for db in dbs:
        instance = db['DBInstanceIdentifier']
        dbuser = db['MasterUsername']
        endpoint = db['Endpoint']
        host = endpoint['Address']
        port = endpoint['Port']
        location = str(db['DBInstanceArn'].split(':')[3])

        logger.info('instance: %s' % instance)
        logger.info('dbuser: %s' % dbuser)
        logger.info('endpoint: %s' % endpoint)
        logger.info('host: %s' % host)
        logger.info('port: %s' % port)
        logger.info('location: %s' % location)

        logger.info ("Accessing instance %s ..." % instance)

        pg = PGHelper(db='postgres', host=host, port=port, dbuser=dbuser)
        con = pg.conn()
        cur = con.cursor()

        def extract_name_query(title, qry):
            logger.info('%s' % (title))
            cur.execute(qry)
            results = cur.fetchall()
            result_names = list(map(lambda x: x[0], results))
            return result_names

        # List all available databases in the same instance
        database_names = extract_name_query(
            'Extracting databases...', 'SELECT * FROM pg_database')

        # Filtering available databases
        default_databases = ['postgres', 'rdsadmin', 'template1', 'template0']
        database_names = list(
            filter(lambda x: x not in default_databases, database_names))
        if database_filters:
            database_names = list(
                filter(lambda x: x in database_filters, database_names))
        
        logger.info("Databases List: %s" % database_names)
        
        # for i in progressbar.progressbar(range(len(database_names))):
        for database_name in database_names:
            # database_name = database_names[i]
            # Change database connection
            logger.info("Accessing %s ..." % database_name)
            con = pg.conn(database=database_name)
            cur = con.cursor()

            # List all available tables in the same instance
            table_query = "SELECT table_name FROM information_schema.tables WHERE table_schema='public' AND table_type='BASE TABLE'"
            table_names = extract_name_query('Extracting tables...', table_query)

            # Filtering available tables
            if table_filters:
                table_names = list(
                    filter(lambda x: x in table_names, table_names))
            # We should also filter away those tables that does not start with hubble as well: ['delayed_jobs', 'ar_internal_metadata', 'schema_migrations', 'audits']
            # We are going to remove hubble_safety_permit_logs as well as it is too big to be exported at the moment. 
            misc_tables = ['delayed_jobs', 'ar_internal_metadata', 'schema_migrations', 'audits', 'hubble_safety_permit_logs']
            table_names = list(
                filter(lambda x: x not in misc_tables, table_names)
            )
            
            logger.info("Tables List: %s" % table_names)
            
            progressbar.streams.wrap_stderr()
            # for table_name in table_names:
            for j in progressbar.progressbar(range(len(table_names))):
                table_name = table_names[j]

                # Rerun for the table when the exception fails
                while True:
                    try:
                        # Save individual tables to CSV first - as we are sending one table at a time, we can del the csv files
                        # as soon as we have uploaded them
                        logger.info("Accessing %s ..." % table_name)
                        # We will save the time based on the latest commit time. Thus, there will be only one file for one table all time
                        # However, they might be of different timestamp due to difference in commit time.
                        
                        s3 = S3Helper()
                        # Extract latest timestamp separately here:
                        # Use this query to extract the latest commit timestamp at that point of time
                        extract_ts_query = "SELECT MAX(pg_xact_commit_timestamp(xmin)) FROM " + table_name + " WHERE pg_xact_commit_timestamp(xmin) IS NOT NULL;"
                        cur.execute(extract_ts_query)
                        latest_timestamp = str(cur.fetchone()[0])

                        # Define needed timestamp to set the csvname we are using.
                        if latest_timestamp and latest_timestamp != 'None':
                            logger.info ("Latest Commit Timestamp from PostGres is: %s" % latest_timestamp)
                            latest_csvtimestamp = s3._convert_s3timestamp(latest_timestamp)
                        
                        # However, if there is no timestamp at all, then use 24 '0's as the default. 
                        else:
                            logger.info ("No Commit Timestamp available in PostGres. Using default.")
                            latest_csvtimestamp = '0' * 24
                        
                        csvname = table_name + "-" + latest_csvtimestamp + ".csv"

                        # Respective paths needed
                        full_folder_path = ("%s/%s/%s/%s") % (DATALAKE_NAME, instance, database_name, table_name)
                        full_table_path = "%s/%s/%s/%s/%s" % (DATALAKE_NAME, instance, database_name, table_name, csvname)
                        s3_path = ("s3://%s") % (full_table_path)

                        # Grab the latest_timestamp from the folder. Ideally, there should only be one file under each table folder, but
                        # we will still segregate them as such for easy referencing.
                        table_timestamp = s3.latest_s3timestamp(full_folder_path)

                        # If we could not get a proper timestamp from s3, it means there is no initial file. 
                        if not table_timestamp:
                            logger.info ("No CSV found in the respective S3 folder. Exporting all rows from table %s to csv." %  table_name)
                            local_csvpath = '/tmp/' + csvname
                            with open(local_csvpath, "w") as csvfile:
                                # Get all of the rows and export them
                                export_query = "COPY " + table_name + " TO STDOUT WITH CSV HEADER"
                                cur.copy_expert(export_query, csvfile)
                        
                        else:
                            logger.info ("CSV File found with Commit Timestamp: %s." % table_timestamp)
                            # Since the timestamp is down to the last milisecond, it is almost impossible for it be miss any rows.
                            # Thus, to save processing time, we share ignore any need to update the table csv if the timestamp is the same.
                            table_csvtimestamp = s3._convert_s3timestamp(table_timestamp) 
                            if table_csvtimestamp == latest_csvtimestamp:
                                logger.info ("The latest Commit Timestamp (%s) and the latest S3 Timestamp (%s) are the same. Proceeeding to next table."
                                % (latest_timestamp, table_timestamp))
                                logger.info('\n')
                                break

                            # If timestamp is 0000.. , we should just use the min datetime to prevent error.
                            if table_csvtimestamp == '0' * 24:
                                table_timestamp = datetime.min
                            
                            # Get only the rows after the committed timestamp retrieved and append that to the current csv.
                            # If there is no results, just go to the next table
                            export_query = "SELECT * FROM " + table_name + " WHERE pg_xact_commit_timestamp(xmin) > %s "
                            cur.execute(export_query, (table_timestamp,))
                            results = cur.fetchall()
                            if not results:
                                logger.info ("No new rows or updates from the current Database.")
                                logger.info('\n')
                                break

                            # Download the file to local storage first, then utilizing it - always save it under /tmp/ directory
                            # The file will also be deleted from s3
                            local_csvpath = s3.download_latest(full_folder_path)
                            with open(local_csvpath, 'a') as csvfile:
                                # Append by downloading the existing csv and append locally.
                                logger.info ("Writing rows into current local CSV File...")
                                for row in results:
                                    writer = csv.writer(csvfile)
                                    writer.writerow(row)
                            
                        # Upload the file to the respective bucket - Replacing or uploading uses the same function
                        # This way of uploading would not resetting the entire path, so it is fine to not add a check.
                        s3.create_folder(full_folder_path, location)
                        s3.upload(local_csvpath, full_table_path)
                        latest_timestamp = s3._convert_timestamp(latest_csvtimestamp)
                        logger.info ('FILE PUT AT: %s with Latest Committed Time (%s)' % (s3_path, latest_timestamp))

                        # Deleting file from /tmp/ after use
                        os.remove(local_csvpath)
                        logger.info ('Local File Deleted')
                        logger.info('\n')
                        break
                    
                    except psycopg2.Error as e:
                        logger.error(e.pgerror)
                        logger.info("Retrying for %s table." % table_name)
                        logger.info('\n')
                        continue
                

# Handler to Accomodate to Lambda Context Manager-----------------------------------------------
def handler(event=None, context=None):

    # Start Time
    start = time.time()

    # The tag or name of the instance we want to enter
    # test_server = 'arn:aws:rds:ap-southeast-1:160830294233:db:companya'
    instance_tags = INSTANCE_TAGS

    # The given companies
    # database_tags = ['companyaworkers']
    database_tags = DATABASE_TAGS

    # The related modules needed
    # correct_tables = []

    full_database_migration(instance_filters=instance_tags, database_filters=database_tags)

    end = time.time()
    seconds = end - start
    time_spent = str(timedelta(seconds=seconds))
    logger.info("Time Spent on Script: %s" % time_spent)


if __name__ == "__main__":
    handler()
