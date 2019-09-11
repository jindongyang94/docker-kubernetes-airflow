import pandas as pd
import psycopg2 as pg
import psycopg2.pool
import pandas.io.sql as psql
import boto3

import os
import json
from collections import OrderedDict
from pprint import pprint

import datetime
import time
import pytz
from tqdm import tqdm

from modules.db_integration_lib.helper import PGHelper, logger


def get_daily_timerange(pivot_time, timezone):
    today = datetime.date.today()
    start_time = today - datetime.timedelta(2)
    end_time = today - datetime.timedelta(1)

    pivot_time = datetime.time.fromisoformat(pivot_time)

    start_time = datetime.datetime.combine(start_time, pivot_time)
    end_time = datetime.datetime.combine(end_time, pivot_time)

    # convert time to UTC
    local_tz = pytz.timezone(timezone)
    start_time = local_tz.localize(start_time)
    end_time = local_tz.localize(end_time)

    return start_time, end_time


def parse_config():
    with open('config.json') as f:
        config = json.load(f, object_pairs_hook=OrderedDict)
    return config


def transfer_table_from_client_to_rds(table, client, client_id, start_time, end_time):
    logger.info('%s client' % client.upper())

    cfg = parse_config()

    temp_table = 'temp_' + table

    client_conn = pg.connect(**cfg['client_db'], database=client)
    client_cur = client_conn.cursor()

    dev_conn = pg.connect(**cfg['dev_db'])
    dev_cur = dev_conn.cursor()

    query = '''
            SELECT *
            FROM %s
            WHERE pg_xact_commit_timestamp(xmin) >= '%s'
            AND pg_xact_commit_timestamp(xmin) < '%s'
            ''' % (table, start_time, end_time)
    result_df = psql.read_sql(query, client_conn)

    # if there is no new data, skip the next part
    if len(result_df) == 0:
        client_cur.close()
        dev_cur.close()
        return 'No data'

    logger.debug('Number of updated records: %s' % len(result_df))

    # get column types
    query = '''
            SELECT column_name, data_type
            FROM information_schema.columns
            WHERE table_name = '%s'
            ''' % (temp_table)
    type_df = psql.read_sql(query, dev_conn)
    type_df = type_df[type_df['column_name'] != 'client_server_id']

    mismatches = set()
    for i in range(len(type_df)):
        if type_df.iloc[i]['data_type'] in ['integer', 'smallint',
                                            'bigint']:  # and result_df.dtypes.iloc[i] == 'float64':
            col_name = type_df.iloc[i]['column_name']
            if col_name in result_df.columns:
                if result_df[col_name].dtypes == 'float64':
                    # print('mismatch')
                    mismatches.add(type_df.iloc[i]['column_name'])

    mismatches = list(mismatches)
    if len(mismatches) == 1 and mismatches[0] == '':
        mismatches = []
    logger.debug('Mismatches: %s' % list(mismatches))

    # convert to compatible types
    for col in mismatches:
        query = '''
                ALTER TABLE %s
                ALTER COLUMN %s TYPE double precision 
                ''' % (temp_table, col)
        dev_cur.execute(query)

    # add client index
    # client_id = int(client_df[client_df['client_name'] == client]['client_id'].iloc[0])
    result_df['client_server_id'] = int(client_id)

    logger.debug('Copy data to temp table')
    result_df.to_csv('temp.csv', index=False)
    save_cols = list(result_df.columns)
    save_cols = ['"%s"' % c for c in save_cols]
    save_cols = ', '.join(save_cols)

    with open('temp.csv', mode='r') as f:
        next(f)
        dev_cur.copy_expert('''COPY %s (%s) FROM STDIN WITH (FORMAT CSV)''' % (temp_table, save_cols), f)

    # convert back to original types
    for col in mismatches:
        query = '''
                ALTER TABLE %s
                ALTER COLUMN %s TYPE integer
                ''' % (temp_table, col)
        dev_cur.execute(query)

    client_cur.close()
    client_conn.close()

    dev_conn.commit()

    dev_cur.close()
    dev_conn.close()

    os.remove('temp.csv')


def transfer_table_from_all_client_to_rds_and_s3(module, table, start_time, end_time):
    cfg = parse_config()

    with open(cfg['table_client_meta']) as f:
        table_client = json.load(f, object_pairs_hook=OrderedDict)

    client_df = pd.read_csv(cfg['client_csv'])
    client_df = client_df[client_df['client_archive'] != 1]

    s3 = boto3.client('s3')

    dev_conn = pg.connect(**cfg['dev_db'])
    dev_cur = dev_conn.cursor()

    temp_table = 'temp_' + table

    query = '''
            drop table if exists %s
            ''' % (temp_table)
    dev_cur.execute(query)
    query = '''
            create table %s
            as (select * from %s where 0=1)
            ''' % (temp_table, table)
    dev_cur.execute(query)
    dev_conn.commit()

    for c_i, client in enumerate(table_client[table], start=1):
        client_id = int(client_df[client_df['client_name'] == client]['client_id'].iloc[0])
        transfer_table_from_client_to_rds(table, client, client_id, start_time, end_time)

    logger.debug('Copy data to temp file')
    # write new data to csv
    with open('temp.csv', mode='w') as f:
        dev_cur.copy_expert('''COPY %s TO STDOUT WITH (FORMAT CSV)''' % temp_table, f)

    # transfer data to s3
    s3_file_name = '%s/%s/%s_%s_%s.csv' % (module, table, table,
                                           start_time.strftime("%Y-%m-%d %H:%M:%S"),
                                           end_time.strftime("%Y-%m-%d %H:%M:%S"))
    logger.debug(s3_file_name)
    s3.upload_file('temp.csv', cfg['s3_bucket'], s3_file_name)

    # if there is no new data, skip transferring to redshift
    query = '''
            select count(*)
            from %s
            ''' % temp_table
    dev_cur.execute(query)
    count = dev_cur.fetchone()[0]
    logger.info('Total number of updated rows: %s' % count)

    if count == 0:
        # drop temp table
        query = '''drop table %s''' % temp_table
        dev_cur.execute(query)

        dev_cur.close()
        dev_conn.close()

        os.remove('temp.csv')
        return 0

    # load data from temp table to main table
    logger.debug('Load new records into main table')
    # delete old records
    query = '''
            delete from %s
            where (%s, %s) in (
                select %s, %s from %s
            )
            ''' % (table, 'id', 'client_server_id',
                   'id', 'client_server_id', temp_table)
    try:
        dev_cur.execute(query)
    except Exception as e:
        print(e)

    # insert new records
    query = '''
            insert into %s
            select * from %s
            ''' % (table, temp_table)
    dev_cur.execute(query)

    # drop temp table
    query = '''drop table %s''' % temp_table
    dev_cur.execute(query)

    dev_conn.commit()

    dev_cur.close()
    dev_conn.close()

    os.remove('temp.csv')
    return count


def transfer_table_from_s3_to_redshift(module, table, start_time, end_time):
    cfg = parse_config()

    redshift_conn = pg.connect(**cfg['redshift_db'])
    redshift_cur = redshift_conn.cursor()

    s3_file_name = '%s/%s/%s_%s_%s.csv' % (module, table, table,
                                           start_time.strftime("%Y-%m-%d %H:%M:%S"),
                                           end_time.strftime("%Y-%m-%d %H:%M:%S"))

    temp_table = 'temp_' + table
    # create temp table
    query = '''
            create table %s
            as (select * from %s where 0=1)
            ''' % (temp_table, table)
    redshift_cur.execute(query)

    # copy data from s3 to temp table
    query = '''
            copy %s
            from 's3://%s/%s'
            iam_role '%s'
            region '%s'
            csv
            -- compupdate on
            ''' % (temp_table, cfg['s3_bucket'], s3_file_name,
                   cfg['redshift_iam_role'], cfg['redshift_region'])
    redshift_cur.execute(query)

    # delete old records
    query = '''
            delete from %s
            where (%s, %s) in (
                select %s, %s from %s
            )
            ''' % (table, 'id', 'client_server_id',
                   'id', 'client_server_id', temp_table)
    try:
        redshift_cur.execute(query)
    except Exception as e:
        print(e)

    # insert new records
    query = '''
            insert into %s
            select * from %s
            ''' % (table, temp_table)
    redshift_cur.execute(query)

    # drop temp table
    query = '''drop table %s''' % temp_table
    redshift_cur.execute(query)

    redshift_conn.commit()

    redshift_cur.close()
    redshift_conn.close()


def transfer_module(module, start_time, end_time):
    logger.info('%s module' % module.upper())
    cfg = parse_config()

    with open(cfg['module_table_meta']) as f:
        module_table = json.load(f, object_pairs_hook=OrderedDict)
    with open(cfg['table_client_meta']) as f:
        table_client = json.load(f, object_pairs_hook=OrderedDict)

    for table in module_table[module]:
        if table in cfg['unused_tables']:
            continue
        if table not in table_client:
            continue

        logger.info('%s table' % table.upper())
        count = transfer_table_from_all_client_to_rds_and_s3(module, table, start_time, end_time)
        if count == 0:
            continue
        logger.info('Copy to redshift')
        transfer_table_from_s3_to_redshift(module, table, start_time, end_time)


def transfer_all_module():
    cfg = parse_config()

    start_time, end_time = get_daily_timerange(cfg['pivot_time'], cfg['timezone'])

    with open(cfg['module_table_meta']) as f:
        module_table = json.load(f, object_pairs_hook=OrderedDict)

    for module in module_table:
        if module in cfg['unused_modules']:
            continue

        transfer_module(module, start_time, end_time)


if __name__ == '__main__':

    transfer_all_module()

