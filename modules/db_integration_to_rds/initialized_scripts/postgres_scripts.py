import pandas as pd
import psycopg2 as pg
import pandas.io.sql as psql

import logging
import os
import glob
import tqdm
import datetime
import boto3
import time

# import config as cfg
# import sys
# sys.path.append('../')
from .. import config as cfg


def create_template():
    dev_conn = pg.connect(**cfg.dev_db)
    dev_cur = dev_conn.cursor()

    for table in cfg.module_tables:
        table_sql = cfg.sql_dir + '/' + table + '.sql'
        print('Running sql file:', table_sql)
        dev_cur.execute(open(table_sql, mode='r').read())

    dev_conn.commit()
    dev_cur.close()
    dev_conn.close()


def add_column_client_id():
    dev_conn = pg.connect(**cfg.dev_db)
    dev_cur = dev_conn.cursor()

    # rename table columns

    for table in cfg.module_tables:
        query = '''
        alter table %s
        add column client_id smallint
        ''' % table

        dev_cur.execute(query)

    dev_conn.commit()
    dev_cur.close()
    dev_conn.close()


def prepend_column_name():
    dev_conn = pg.connect(**cfg.dev_db)
    dev_cur = dev_conn.cursor()

    # rename table columns
    query = '''
    select table_name, column_name
    from information_schema.columns
    where table_name in (
        select table_name
        from information_schema.tables
        where table_schema='public'
        and table_type='BASE TABLE'
    )
    and table_name != 'attendance_mart'
    and table_name != 'hubble_clients_clients'
    '''

    result = psql.read_sql(query, dev_conn)
    for i, row in tqdm.tqdm(result.iterrows()):
        query = '''
        alter table %s
        rename %s to %s
        ''' % (row['table_name'], row['column_name'], cfg.entity_mapping[row['table_name']] + '_' + row['column_name'])

        dev_cur.execute(query)

    dev_conn.commit()
    dev_cur.close()
    dev_conn.close()