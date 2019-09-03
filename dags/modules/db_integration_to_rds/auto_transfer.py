import pandas as pd
import psycopg2 as pg
import pandas.io.sql as psql
import boto3

import logging

import datetime
import time
import pytz

from . import config as cfg


logging.getLogger(__name__)


def convert_to_utc(dt, zone='Singapore'):
    local_tz = pytz.timezone(zone)
    local_dt = local_tz.localize(dt)
    utc_dt = local_dt.astimezone(pytz.utc)
    return utc_dt


def initial_data_transfer():
    logging.basicConfig(level=logging.INFO)

    client_df = pd.read_csv(cfg.client_csv)

    logging.info('Connect to dev database')
    dev_conn = pg.connect(**cfg.dev_db)
    dev_cur = dev_conn.cursor()

    logging.info('Connect to Redshift cluster')
    redshift_conn = pg.connect(**cfg.redshift_db)
    redshift_cur = redshift_conn.cursor()

    s3 = boto3.client('s3')

    # get pivot timestamps
    today = datetime.date.today()
    first_pivot = today - datetime.timedelta(1)
    pivot_time = datetime.time(12, 0, 0)
    first_pivot = datetime.datetime.combine(first_pivot, pivot_time)

    logging.info('Pull data till %s' % first_pivot)

    t_1 = time.time()
    for table in cfg.module_tables:
        t_start = time.time()
        logging.info('Process %s table' % table.upper())

        conflict_clients = []
        for row_id, client_row in client_df.iterrows():
            logging.info('Loading data (%d/%d) from %s' % (row_id+1, len(client_df), client_row['client_name']))

            mismatches = set()
            client_conn = pg.connect(**cfg.prod_db, database=client_row['client_name'])
            client_cur = client_conn.cursor()

            # query to grab all data
            query = '''
            select *
            from %s
            where pg_xact_commit_timestamp(xmin) < '%s'
            or pg_xact_commit_timestamp(xmin) is null
            ''' % (table, first_pivot)
            result_df = psql.read_sql(query, client_conn)

            # try:
            #     result_df = psql.read_sql(query, client_conn)
            # except psql.DatabaseError:
            #     logging.warning('Client %s is busy. Reconnect later' % client_row['client_name'])

            # query to grab column types
            query = '''
                    SELECT column_name, data_type
                    FROM information_schema.columns
                    WHERE table_name = '%s'
                    ''' % (table)
            type_df = psql.read_sql(query, dev_conn)

            type_df = type_df[type_df['column_name'] != cfg.entity_mapping[table] + '_client_id']

            if len(result_df.columns) > len(type_df['column_name']):
                print('Inconsistent schema. Using merging strategy: %s attributes' % cfg.merge_strat.upper())
                if cfg.merge_strat == 'drop':
                    type_cols = [col_name.replace(cfg.entity_mapping[table] + '_', '') for col_name in type_df['column_name']]
                    drop_cols = result_df.columns.difference(type_cols)
                    print('Drop columns:', drop_cols)
                    result_df = result_df.drop(columns=drop_cols)
                elif cfg.merge_strat == 'keep':
                    # to be implemented
                    pass

            for i in range(len(type_df)):
                if type_df.iloc[i]['data_type'] in ['integer', 'smallint'] and result_df.dtypes.iloc[i] == 'float64':
                    mismatches.add(type_df.iloc[i]['column_name'])

            mismatches = list(mismatches)
            if len(mismatches) == 1 and mismatches[0] == '':
                mismatches = []

            for col in mismatches:
                query = '''
                        ALTER TABLE %s
                        ALTER COLUMN %s TYPE double precision
                        ''' % (table, col)
                dev_cur.execute(query)

            # add client index
            result_df['client_id'] = int(client_row['client_id'])

            # write queries
            result_df.to_csv('tmp.csv', index=False)
            with open('tmp.csv', mode='r') as f:
                next(f)
                dev_cur.copy_expert('''COPY %s FROM STDIN WITH (FORMAT CSV)''' % table, f)

            for col in mismatches:
                query = '''
                        ALTER TABLE %s
                        ALTER COLUMN %s TYPE integer
                        ''' % (table, col)
                dev_cur.execute(query)

            client_cur.close()
            client_conn.close()

        logging.info('Copy data to s3 bucket')
        # write data to csv then
        # copy data to s3
        with open('temp.txt', mode='w') as f:
            dev_cur.copy_to(f, table, sep='|')

        # s3_file_name = '%s/%s_%s.txt' % (cfg.module_name, table, first_pivot.date())
        # logging.debug(s3_file_name)
        # # print(s3_file_name)
        # s3.upload_file('temp.txt', cfg.s3_bucket, s3_file_name)

        ########################################################################################################################
        # # transfer data to redshift
        # logging.info('Upload data to Redshift')
        # # copy data from s3 to temp table
        # query = '''
        # copy %s
        # from 's3://%s/%s/%s_%s.txt'
        # iam_role '%s'
        # region '%s'
        # delimiter '|'
        # ''' % (table, cfg.s3_bucket, cfg.module_name, table, first_pivot.date(), cfg.redshift_iam_role, cfg.redshift_region)
        # redshift_cur.execute(query)
        #
        # logging.info('Transfer %s table successfully' % table)
        # t_end = time.time()
        # logging.info('Transfer %s table took %s seconds' % (table, round(t_end - t_start)))
        # logging.info('Process took %s seconds so far' % (round(t_end - t_1)))

    dev_conn.commit()
    dev_cur.close()
    dev_conn.close()

    redshift_conn.commit()
    redshift_cur.close()
    redshift_conn.close()


def automatic_update(daily=True,
                     last_pivot=None,
                     curr_pivot=None,
                     pivot_time=None,
                     timezone='Singapore',

                     client_csv='',
                     dev_db=None,
                     prod_db=None,
                     redshift_db=None,
                     redshift_iam_role='',
                     redshift_region='',
                     s3_bucket='',

                     module_name='',
                     module_tables=None,
                     entity_mapping=None,

                     merge_strat='drop',
                     verbose=False
                     ):
    """
    Pull data between two timestamps (Singapore timezone) and transfer data to PostgreSQL and Redshift
    :param daily: specify whether running for daily update or for specific time range update. Default is true
    :param last_pivot: first timestamp. If None, pull all data from the beginning. Format: YYYY-MM-DD HH:MM:SS
    :param curr_pivot: second timestamp. If None, pull all data till the moment this function runs. Format: YYYY-MM-DD HH:MM:SS
    :param pivot_time: if daily=True, pivot time is the specific time of day to update until it, to be combined with the date to form a timestamp. Format: HH:MM:SS
    :param timezone: timezone of all the timestamps. Default is Singapore
    :param client_csv: csv file containing client information
    :param dev_db: connection information of middle database
    :param prod_db: connection information of production database
    :param redshift_db: connection information of redshift data warehouse
    :param redshift_iam_role: IAM role allows copying data from s3 to Redshift
    :param redshift_region: region of Redshift instance in AWS
    :param s3_bucket: s3 bucket name
    :param module_name: module name
    :param module_tables:
    :param entity_mapping:
    :param merge_strat:
    :param verbose:
    :return:
    """

    # sql injection is not prioritized when coding this function
    # please consider carefully when using for other purposes
    # will need rewritten to avoid sql injection

    if verbose:
        logging.basicConfig(level=logging.INFO)

    client_df = pd.read_csv(client_csv)
    client_df = client_df[client_df['client_archive'] != 1]

    logging.info('Connect to dev database')
    dev_conn = pg.connect(**dev_db)
    dev_cur = dev_conn.cursor()

    logging.info('Connect to Redshift cluster')
    redshift_conn = pg.connect(**redshift_db)
    redshift_cur = redshift_conn.cursor()

    s3 = boto3.client('s3')

    # get pivot timestamps
    if daily:
        today = datetime.date.today()
        last_pivot = today - datetime.timedelta(2)
        curr_pivot = today - datetime.timedelta(1)

        pivot_time = datetime.time.fromisoformat(pivot_time)

        last_pivot = datetime.datetime.combine(last_pivot, pivot_time)
        curr_pivot = datetime.datetime.combine(curr_pivot, pivot_time)
    else:
        if not curr_pivot:
            curr_pivot = datetime.datetime.now()
        else:
            curr_pivot = datetime.datetime.fromisoformat(curr_pivot)
        if not last_pivot:
            # to be implemented
            raise NotImplementedError
        else:
            last_pivot = datetime.datetime.fromisoformat(last_pivot)

    logging.info('Pull date from %s to %s (%s timezone)' % (last_pivot, curr_pivot, timezone))

    # convert time to UTC
    local_tz = pytz.timezone(timezone)
    last_pivot = local_tz.localize(last_pivot)
    curr_pivot = local_tz.localize(curr_pivot)

    # transfer data
    for table in module_tables:
        logging.info('Process %s table' % table.upper())

        # create a temp table to store the new records
        temp_table = 'temp_' + table
        query = '''
        create table %s
        as (select * from %s where 0=1)
        ''' % (temp_table, table)
        dev_cur.execute(query)

        for row_id, client_row in client_df.iterrows():
            logging.info('Loading data (%d/%d) from %s' % (row_id + 1, len(client_df), client_row['client_name']))

            client_conn = pg.connect(**prod_db, database=client_row['client_name'])
            client_cur = client_conn.cursor()

            # get modified records (both updated and created)
            query = '''
            SELECT *
            FROM %s
            WHERE pg_xact_commit_timestamp(xmin) >= '%s'
            AND pg_xact_commit_timestamp(xmin) < '%s'
            ''' % (table, last_pivot, curr_pivot)
            result_df = psql.read_sql(query, client_conn)
            logging.info('Number of updated records: %s' % len(result_df))

            # type transforming to handle pandas type auto-converting, please refer to these links below
            # https://github.com/pandas-dev/pandas/issues/13049
            # https://stackoverflow.com/questions/21287624/convert-pandas-column-containing-nans-to-dtype-int/21290084#21290084

            # get column types
            query = '''
            SELECT column_name, data_type
            FROM information_schema.columns
            WHERE table_name = '%s'
            ''' % (temp_table)
            type_df = psql.read_sql(query, dev_conn)

            type_df = type_df[type_df['column_name'] != entity_mapping[table] + '_client_id']

            # handle extra columns
            mismatches = set()
            if len(result_df.columns) > len(type_df['column_name']):
                logging.info('Inconsistent schema. Using merging strategy: %s extra columns' % merge_strat.upper())
                if merge_strat == 'drop':
                    type_cols = [col_name.replace(entity_mapping[table] + '_', '') for col_name in
                                 type_df['column_name']]
                    drop_cols = result_df.columns.difference(type_cols)
                    logging.debug('Drop columns: %s' % list(drop_cols))
                    result_df = result_df.drop(columns=drop_cols)
                elif merge_strat == 'keep':
                    # to be implemented
                    raise NotImplementedError

            for i in range(len(type_df)):
                if type_df.iloc[i]['data_type'] in ['integer', 'smallint'] and result_df.dtypes.iloc[i] == 'float64':
                    mismatches.add(type_df.iloc[i]['column_name'])

            mismatches = list(mismatches)
            if len(mismatches) == 1 and mismatches[0] == '':
                mismatches = []

            logging.debug('Mismatches: %s' % list(mismatches))

            # convert to compatible types
            for col in mismatches:
                query = '''
                ALTER TABLE %s
                ALTER COLUMN %s TYPE double precision 
                ''' % (temp_table, col)
                dev_cur.execute(query)

            # add client index
            result_df['client_id'] = int(client_row['client_id'])

            logging.debug('Copy data to temp table')
            # write queries to temp table
            # copy file to s3
            result_df.to_csv('tmp.csv', index=False)
            with open('tmp.csv', mode='r') as f:
                next(f)
                dev_cur.copy_expert('''COPY %s FROM STDIN WITH (FORMAT CSV)''' % temp_table, f)

            # convert back to original types
            for col in mismatches:
                query = '''
                ALTER TABLE %s
                ALTER COLUMN %s TYPE integer
                ''' % (temp_table, col)
                dev_cur.execute(query)

            client_cur.close()
            client_conn.close()

        logging.info('Load new records into main table')

        # delete old records
        query = '''
        delete from %s
        where (%s, %s) in (
            select %s, %s from %s
        )
        ''' % (table, entity_mapping[table] + '_id', entity_mapping[table] + '_client_id',
               entity_mapping[table] + '_id', entity_mapping[table] + '_client_id', temp_table)
        dev_cur.execute(query)

        # insert new records
        query = '''
        insert into %s
        select * from %s
        ''' % (table, temp_table)
        dev_cur.execute(query)

        logging.info('Copy data to s3 bucket')
        # write data to csv then
        # copy data to s3
        with open('temp.txt', mode='w') as f:
            dev_cur.copy_to(f, temp_table, sep='|')

        s3_file_name = '%s/%s_%s.txt' % (module_name, table, curr_pivot.date())
        logging.debug(s3_file_name)
        # print(s3_file_name)
        s3.upload_file('temp.txt', s3_bucket, s3_file_name)

        # drop temp table
        query = '''drop table %s''' % temp_table
        dev_cur.execute(query)

########################################################################################################################
        logging.info('Upload data to Redshift')
        # transfer data to redshift

        # create temp table
        query = '''
        create table %s
        as (select * from %s where 0=1)
        ''' % (temp_table, table)
        redshift_cur.execute(query)

        # copy data from s3 to temp table
        query = '''
        copy %s
        from 's3://%s/%s/%s_%s.txt'
        iam_role '%s'
        region '%s'
        delimiter '|'
        ''' % (temp_table, s3_bucket, module_name, table, curr_pivot.date(), redshift_iam_role, redshift_region)
        redshift_cur.execute(query)

        query = '''
        select count(*)
        from %s
        ''' % temp_table
        redshift_cur.execute(query)
        count = redshift_cur.fetchone()[0]
        print('Total number of updated rows: %s' % count)

        # delete old records
        query = '''
        delete from %s
        where (%s, %s) in (
            select %s, %s from %s
        )
        ''' % (table, entity_mapping[table] + '_id', entity_mapping[table] + '_client_id',
               entity_mapping[table] + '_id', entity_mapping[table] + '_client_id', temp_table)
        redshift_cur.execute(query)

        # insert new records
        query = '''
        insert into %s
        select * from %s
        ''' % (table, temp_table)
        redshift_cur.execute(query)

        # drop temp table
        query = '''drop table %s''' % temp_table
        redshift_cur.execute(query)

    # redshift_conn.commit()
    redshift_cur.close()
    redshift_conn.close()

    # dev_conn.commit()
    dev_cur.close()
    dev_conn.close()

def handler(event=None, context=None):
    """
    To wrap overall function for Lambda or any other overhead usage when there is a need for triggers. 
    """
    return automatic_update(daily=True,
                     last_pivot=None,
                     curr_pivot=None,
                     pivot_time=cfg.pivot_time,
                     timezone='Singapore',

                     client_csv=cfg.client_csv,
                     dev_db=cfg.dev_db,
                     prod_db=cfg.prod_db,
                     redshift_db=cfg.redshift_db,
                     redshift_iam_role=cfg.redshift_iam_role,
                     redshift_region=cfg.redshift_region,
                     s3_bucket=cfg.s3_bucket,

                     module_name=cfg.module_name,
                     module_tables=cfg.module_tables,
                     entity_mapping=cfg.entity_mapping,

                     merge_strat=cfg.merge_strat,
                     verbose=True
                     )


if __name__ == '__main__':
    # automatic_update()
    t1 = time.time()
    handler()
    print(time.time() - t1)
