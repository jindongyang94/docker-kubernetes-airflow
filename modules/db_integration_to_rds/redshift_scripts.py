import pandas as pd
import numpy as np
import psycopg2 as pg
import pandas.io.sql as psql

import os
import glob
import tqdm
import logging

import config as cfg

import math
import pprint
import json
from collections import OrderedDict


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

        template_folder = cfg.rs_dir
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
        sql_dir = cfg.rs_dir + '/' + table + '.sql'
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
    client_name varchar(32),
    client_archive smallint
    )
    '''
    redshift_cur.execute(query)

    query = '''
    copy hubble_clients_clients
    from 's3://warehouse-attendance/attendance/hubble_clients_clients.csv'
    iam_role '%s'
    region '%s'
    csv
    ignoreheader 1
    ''' % (cfg.redshift_iam_role, cfg.redshift_region)
    redshift_cur.execute(query)

    redshift_conn.commit()
    redshift_cur.close()
    redshift_conn.close()


def scan_database_to_optimize_type():
    client_df = pd.read_csv(cfg.client_csv)
    client_df = client_df[client_df['client_archive'] != 1]

    table_column_len = {}

    for row_id, client_row in tqdm.tqdm(client_df.iterrows()):
        logging.info('Loading data (%d/%d) from %s' % (row_id + 1, len(client_df), client_row['client_name']))

        client_conn = pg.connect(**cfg.prod_db, database=client_row['client_name'])
        client_cur = client_conn.cursor()

        query = '''
        select table_name, column_name,
        (xpath('/row/max/text()',query_to_xml(format('select max(length(%I)) from %I.%I', column_name, table_schema, table_name), true, true, '')))[1]::text::int as max_length
        from information_schema.columns
        where table_name like 'hubble_%'
        and (data_type = 'character varying'
        or data_type = 'text')
        '''
        result = psql.read_sql(query, client_conn)
        result['max_length'] = result['max_length'].fillna(0)
        result['max_length'] = result['max_length'].astype(np.int)

        for i, col_row in result.iterrows():
            table_name, column_name, col_length = col_row['table_name'], col_row['column_name'], col_row['max_length']
            if table_name not in table_column_len:
                table_column_len[table_name] = {}

            if column_name not in table_column_len[table_name]:
                table_column_len[table_name][column_name] = col_length
            else:
                if col_length > table_column_len[table_name][column_name]:
                    table_column_len[table_name][column_name] = col_length

        result = psql.read_sql(query, client_conn)
        print(result)

        client_cur.close()
        client_conn.close()

    # pprint.pprint(table_column_len)

    # with open('table_column_length.json', mode='w') as f:
    #     json.dump(table_column_len, f)


def handle_array_type(table, column):
    # table = 'hubble_leave_leave_applications'
    # column = 'attachments'

    with open('metadata/table_client.json') as f:
        table_client = json.load(f, object_pairs_hook=OrderedDict)

    max_length = 0
    for client in table_client[table]:
        client_conn = pg.connect(**cfg.prod_db, database=client)
        client_cur = client_conn.cursor()

        query = '''
        select max(length(array_to_json(%s)::varchar))
        from %s
        ''' % (column, table)
        result = psql.read_sql(query, client_conn)
        result = list(result['max'])[0]

        if result and result > max_length:
            max_length = result

        # print(client)
        # print(result)

        client_cur.close()
        client_conn.close()
    # print(max_length)
    return max_length


def generate_all_redshift_templates():
    with open('metadata/table_column.json') as f:
        table_column = json.load(f, object_pairs_hook=OrderedDict)
    with open('metadata/table_column_length.json') as f:
        table_column_len = json.load(f)

    for table in tqdm.tqdm(table_column):
        col_data = table_column[table]

        for c in col_data:
            if col_data[c] in ['character varying', 'text']:
                if table_column_len[table][c] != 0:
                    col_data[c] = 'varchar(%s)' % int(table_column_len[table][c] * 1.5)
                else:
                    col_data[c] = 'varchar(1)'
            elif col_data[c] == 'time without time zone':
                col_data[c] = 'varchar(8)'
            elif col_data[c] == 'ARRAY':
                max_length = handle_array_type(table, c)
                col_data[c] = 'varchar(%s)' % int(max_length * 1.5)
            elif col_data[c] == 'json':
                # to be implemented more
                col_data[c] = 'varchar(256)'
            elif col_data[c] == 'bytea':
                # to be implemented
                col_data[c] = 'varchar(256)'

        primary_keys = ['"client_server_id"']
        if 'id' in col_data:
            primary_keys.append('"id"')
        primary_keys = ', '.join(primary_keys)

        query_params = ['"%s" %s' % (c, col_data[c]) for c in col_data]
        query_params = ',\n'.join(query_params)
        rs_sql = '''
create table %s
(
"client_server_id" smallint,
%s,
primary key (%s)
)
compound sortkey(%s)
''' % (table, query_params, primary_keys, primary_keys)

        with open('redshift_templates/%s.sql' % table, mode='w') as f:
            f.write(rs_sql)


def create_all_tables():
    redshift_conn = pg.connect(**cfg.redshift_db)
    redshift_cur = redshift_conn.cursor()

    sql_dir = 'redshift_templates'
    for sql_file in sorted(glob.glob(sql_dir + '/*.sql')):
        table = os.path.basename(sql_file).replace('.sql', '')
        print(table)
        if table in ['hubble_job_queues', 'hubble_job_queues_job_buffers']:
            continue

        query = '''drop table if exists %s''' % table
        redshift_cur.execute(query)

        with open(sql_file) as f:
            query = f.read()
            redshift_cur.execute(query)

    redshift_conn.commit()
    redshift_cur.close()
    redshift_conn.close()


if __name__ == '__main__':
    # optimize_type()
    # generate_redshift_templates()
    # create_tables()
    # create_client_table()
    # scan_database_to_optimize_type()
    # handle_array_type()

    # generate_all_redshift_templates()
    create_all_tables()