import pandas as pd
import numpy as np
import psycopg2 as pg
import pandas.io.sql as psql

import os
import glob
import tqdm
import logging
import math

# import config as cfg
# import sys
# sys.path.append('../')
from .. import config as cfg


def generate_redshift_templates():
    dev_conn = pg.connect(**cfg.dev_db)
    dev_cur = dev_conn.cursor()

    for table in cfg.module_tables:
        query = '''
            SELECT column_name, data_type
            from information_schema.columns
            where table_name = '%s'
            ''' % table

        type_df = psql.read_sql(query, dev_conn)

        for row_id, col_row in type_df.iterrows():
            if col_row['data_type'] in ['character varying', 'text']:
                query = '''
                select max(length(%s))
                from %s
                ''' % (col_row['column_name'], table)
                dev_cur.execute(query)
                result = dev_cur.fetchone()[0]

                if result is not None:
                    col_row['data_type'] = 'varchar(%s)' % 2**(math.floor(math.log2(result))+1)
                else:
                    col_row['data_type'] = 'varchar(256)'

        # convert data types from PostgreSQL to Redshift
        for type_name in cfg.postgresql_to_redshift_types:
            type_df.loc[type_df['data_type'] == type_name, 'data_type'] = cfg.postgresql_to_redshift_types[type_name]

        query_params = ['%s %s' % (column['column_name'], column['data_type']) for (row_id, column) in type_df.iterrows()]
        query_params = ',\n'.join(query_params)
        # print(query_params)

        template = '''
create table %s
(
%s
)
''' % (table, query_params)

        # print(template)

        template_folder = 'rs_templates'
        os.makedirs(template_folder) if not os.path.exists(template_folder) else None

        with open(template_folder + '/' + table + '.sql', mode='w') as f:
            f.write(template)

    dev_cur.close()
    dev_conn.close()


def optimize_type():
    dev_conn = pg.connect(**cfg.dev_db)
    dev_cur = dev_conn.cursor()

    for table in cfg.module_tables:
        print()
        print(table)

        query = '''
            SELECT column_name, data_type
            from information_schema.columns
            where table_name = '%s'
            ''' % table

        type_df = psql.read_sql(query, dev_conn)

        for row_id, col_row in type_df.iterrows():
            if col_row['data_type'] in ['character varying', 'text']:
                query = '''
                select max(length(%s))
                from %s
                ''' % (col_row['column_name'], table)
                dev_cur.execute(query)
                result = dev_cur.fetchone()
                print(col_row['column_name'], result)

        break

    dev_cur.close()
    dev_conn.close()


def create_tables():
    logging.basicConfig(level=logging.INFO)
    logging.getLogger(__name__)

    client_df = pd.read_csv(cfg.client_csv)
    logging.debug(len(client_df))
    logging.debug(client_df.head())

    redshift_conn = pg.connect(**cfg.redshift_db)
    redshift_cur = redshift_conn.cursor()
    logging.info('Connect to Redshift cluster successfully')

    for table in cfg.module_tables:
        sql_dir = 'rs_templates/' + table + '.sql'
        logging.info('Run %s' % sql_dir)
        with open(sql_dir, mode='r') as f:
            query = f.read()

        redshift_cur.execute(query)

    redshift_conn.commit()
    redshift_cur.close()
    redshift_conn.close()


def create_client_table():
    redshift_conn = pg.connect(**cfg.redshift_db)
    redshift_cur = redshift_conn.cursor()

    query = '''
    create table hubble_clients_clients
    (
    client_id smallint,
    client_name varchar(32)
    )
    '''
    redshift_cur.execute(query)

    query = '''
    copy hubble_clients_clients
    from 's3://warehouse-attendance/attendance/test_client_sv.csv'
    iam_role '%s'
    region '%s'
    csv
    ignoreheader 1
    ''' % (cfg.redshift_iam_role, cfg.redshift_region)
    redshift_cur.execute(query)

    redshift_conn.commit()
    redshift_cur.close()
    redshift_conn.close()


if __name__ == '__main__':
    # optimize_type()
    # generate_redshift_templates()
    # create_tables()
    # create_client_table()
    pass