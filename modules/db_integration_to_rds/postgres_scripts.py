import pandas as pd
import psycopg2 as pg
import pandas.io.sql as psql
import boto3

import os
import glob
import tqdm
import datetime
import time
from collections import OrderedDict
import json
import pprint

from modules.db_integration_lib.helper import PGHelper, logger

with open("../db_integration_lib/config.json", 'r') as f:
    cfg = json.loads(f)


def create_template():
    postgres = PGHelper(**cfg.dev_db, type_db='dev')
    dev_conn = postgres.conn()
    dev_cur = dev_conn.cursor()

    for table in cfg.module_tables:
        table_sql = cfg.sql_dir + '/' + table + '.sql'
        print('Running sql file:', table_sql)
        dev_cur.execute(open(table_sql, mode='r').read())

    dev_conn.commit()
    dev_cur.close()
    dev_conn.close()


def add_column_client_id():
    postgres = PGHelper(**cfg.dev_db, type_db='dev')
    dev_conn = postgres.conn()
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
    postgres = PGHelper(**cfg.dev_db, type_db='dev')
    dev_conn = postgres.conn()
    dev_cur = dev_conn.cursor()

    table_list = ["'%s'" % t for t in cfg.module_tables]
    table_list = ', '.join(table_list)

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
    and table_name in (%s)
    ''' % table_list

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


def crawl_database():
    client_df = pd.read_csv(cfg.client_csv)
    client_df = client_df[client_df['client_archive'] != 1]

    table_client = {}

    for row_id, client_row in client_df.iterrows():
        logger.info('Loading data (%d/%d) from %s' % (row_id+1, len(client_df), client_row['client_name']))

        client_conn = pg.connect(**cfg.prod_db, database=client_row['client_name'])
        client_cur = client_conn.cursor()

        query = '''
        select table_name
        from information_schema.tables
        where table_schema = 'public'
        and table_name like 'hubble_%'
        '''

        result = psql.read_sql(query, client_conn)
        print(len(result))

        for tbl in result['table_name']:
            if tbl not in table_client:
                table_client[tbl] = [client_row['client_name']]
            else:
                table_client[tbl].append(client_row['client_name'])

        client_cur.close()
        client_conn.close()

        # break

    table_column = {}
    for row_id, client_row in tqdm.tqdm(client_df.iterrows()):
        # logger.info('Loading data (%d/%d) from %s' % (row_id + 1, len(client_df), client_row['client_name']))

        client_conn = pg.connect(**cfg.prod_db, database=client_row['client_name'])
        client_cur = client_conn.cursor()

        query = '''
                select table_name, column_name, data_type 
                from information_schema.columns
                where table_schema = 'public'
                and table_name like 'hubble_%'
                order by ordinal_position
                '''
        result = psql.read_sql(query, client_conn)

        for i, col_row in result.iterrows():
            table_name, column_name, data_type = col_row['table_name'], col_row['column_name'], col_row['data_type']

            if table_name not in table_column:
                table_column[table_name] = OrderedDict()
            if column_name not in table_column[table_name]:
                table_column[table_name][column_name] = data_type

        # print(result)

        client_cur.close()
        client_conn.close()
        # break

    print(table_client)
    print(table_column)

    with open('table_client.json', mode='w') as f:
        json.dump(table_client, f)

    with open('table_column.json', mode='w') as f:
        json.dump(table_column, f)


def generate_all_templates():
    with open('metadata/table_column.json') as f:
        table_column = json.load(f, object_pairs_hook=OrderedDict)

    for table in tqdm.tqdm(table_column):
        col_data = table_column[table]

        for c in col_data:
            if col_data[c] == 'ARRAY':
                col_data[c] = 'character varying'

        query_params = ['"%s" %s' % (c, col_data[c]) for c in col_data]
        query_params = ',\n'.join(query_params)
        postgres_sql = '''
create table %s
(
"client_server_id" smallint,
%s
)
''' % (table, query_params)

        with open('postgres_templates/%s.sql' % table, mode='w') as f:
            f.write(postgres_sql)


def create_all_table():
    postgres = PGHelper(**cfg.dev_db, type_db='dev')
    dev_conn = postgres.conn()
    dev_cur = dev_conn.cursor()

    sql_dir = 'postgres_templates'
    for sql_file in sorted(glob.glob(sql_dir + '/*.sql')):
        print(os.path.basename(sql_file))
        with open(sql_file) as f:
            query = f.read()
            try:
                dev_cur.execute(query)
            except Exception as e:
                print(os.path.basename(sql_file))
                print(e)

    dev_conn.commit()
    dev_cur.close()
    dev_conn.close()


def map_table_to_module():
    templates_dir = 'postgres_templates'

    table_module_mapping = {}
    for module in cfg.module_list:
        table_module_mapping[module] = []

    for sql_file in sorted(glob.glob(templates_dir + '/*.sql')):
        table = os.path.basename(sql_file).replace('.sql', '')

        for module in cfg.module_list:
            if table.startswith('hubble_' + module):
                table_module_mapping[module].append(table)
                break
        else:
            table_module_mapping['other'].append(table)

    with open('metadata/table_module_mapping.json', mode='w') as f:
        json.dump(table_module_mapping, f)

    pprint.pprint(table_module_mapping)


def check_usage():
    client_df = pd.read_csv(cfg.client_csv)
    client_df = client_df[client_df['client_archive'] != 1]

    table_client_usage = {}

    for row_id, client_row in client_df.iterrows():
        logger.info('Loading data (%d/%d) from %s' % (row_id + 1, len(client_df), client_row['client_name']))

        postgres = PGHelper(**cfg.prod_db, dbname=client_row['client_name'], type_db='prod')
        client_conn = postgres.conn()
        client_cur = client_conn.cursor()

        query = '''
            select table_schema, 
       table_name, 
       (xpath('/row/cnt/text()', xml_count))[1]::text::int as row_count
from (
  select table_name, table_schema, 
         query_to_xml(format('select count(*) as cnt from %I.%I', table_schema, table_name), false, true, '') as xml_count
  from information_schema.tables
  where table_schema = 'public' --<< change here for the schema you want
  and table_name like 'hubble_%'
) t
            '''

        result = psql.read_sql(query, client_conn)
        result = result[result['row_count'] > 0]

        for tbl in result['table_name']:
            if tbl not in table_client_usage:
                table_client_usage[tbl] = [client_row['client_name']]
            else:
                table_client_usage[tbl].append(client_row['client_name'])

        client_cur.close()
        client_conn.close()

    with open('metadata/table_client_usage.json', mode='w') as f:
        json.dump(table_client_usage, f)


if __name__ == '__main__':

    # create_template()
    # add_column_client_id()
    # prepend_column_name()

    # crawl_database()
    # generate_all_templates()
    # create_all_table()
    # map_table_to_module()
    check_usage()