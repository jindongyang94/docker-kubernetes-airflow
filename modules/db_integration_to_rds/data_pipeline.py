import pandas as pd
import psycopg2 as pg
import psycopg2.pool
import pandas.io.sql as psql
import boto3

import os
import logging
import json
from collections import OrderedDict
from pprint import pprint

import datetime
import time
import pytz
from tqdm import tqdm


def get_timerange(periodic_mode, last_pivot, curr_pivot, pivot_time, timezone):
    '''
    Return the start time and end time to grab data between these times
    :param periodic_mode:
    :param last_pivot:
    :param curr_pivot:
    :param pivot_time:
    :param timezone:
    :return:
    '''
    if periodic_mode == 'daily':
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

    logging.info('Pull data from %s to %s (%s timezone)' % (last_pivot, curr_pivot, timezone))

    # convert time to UTC
    local_tz = pytz.timezone(timezone)
    last_pivot = local_tz.localize(last_pivot)
    curr_pivot = local_tz.localize(curr_pivot)

    return last_pivot, curr_pivot


def initial_data_transfer():
    '''
    Transfer all existing data end-to-end from production to redshift. Run it the first time only.
    :return:
    '''
    logging.basicConfig(level=logging.INFO)

    client_df = pd.read_csv(cfg.client_csv)
    client_df = client_df[client_df['client_archive'] != 1]

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
    pivot_time = datetime.time(4, 0, 0)
    first_pivot = datetime.datetime.combine(first_pivot, pivot_time)

    timezone = 'Singapore'
    local_tz = pytz.timezone(timezone)
    first_pivot = local_tz.localize(first_pivot)

    logging.info('Pull data till %s' % first_pivot)

    with open('metadata/table_module_mapping.json') as f:
        table_module = json.load(f, object_pairs_hook=OrderedDict)
    with open('metadata/table_client_usage.json') as f:
        table_client = json.load(f, object_pairs_hook=OrderedDict)

    num_iters = 0
    for t in table_client:
        num_iters += len(table_client[t])

    t_1 = time.time()
    error_list = []

    checkpoint = False
    # checkpoint_table = 'hubble_safety_permits'

    with tqdm(total=num_iters) as pbar:
        for m_i, module in enumerate(table_module, start=1):
            # module = 'leave'

            if module in ['form_builder']:
                continue

            for t_i, table in enumerate(table_module[module], start=1):
                # table = 'hubble_leave_leave_applications'
                t_start = time.time()

                if table in ['hubble_job_queues', 'hubble_job_queues_job_buffers']:
                    continue

                if table not in table_client:
                    continue

                if table == 'hubble_quality_inspection_types':
                    checkpoint = True
                if not checkpoint:
                    pbar.update(len(table_client[table]))
                    continue

                # make sure table empty by truncating
                query = '''
                truncate %s
                ''' % table
                dev_cur.execute(query)
                redshift_cur.execute(query)

                # count = 0
                for c_i, client in enumerate(table_client[table], start=1):
                    # if count > 2:
                    #     break
                    # count += 1

                    logging.info('Processing %s module (%s/%s) - %s table (%s/%s) - %s client (%s/%s)'
                                 % (module.upper(), m_i, len(table_module),
                                    table.upper(), t_i, len(table_module[module]),
                                    client.upper(), c_i, len(table_client[table]))
                                 )

                    client_id = int(client_df[client_df['client_name'] == client]['client_id'].iloc[0])

                    mismatches = set()
                    client_conn = pg.connect(**cfg.prod_db, database=client)
                    client_cur = client_conn.cursor()

                    # query to grab all data
                    query = '''
                    select *
                    from %s
                    where pg_xact_commit_timestamp(xmin) < '%s'
                    or pg_xact_commit_timestamp(xmin) is null
                    ''' % (table, first_pivot)
                    result_df = psql.read_sql(query, client_conn)
                    # result_df = restarter(10, psql.read_sql, query, client_conn)
                    if not isinstance(result_df, pd.DataFrame):
                        error_list.append((m_i, module, t_i, table, c_i, client))
                        continue

                    # query to grab column types
                    query = '''
                            SELECT column_name, data_type
                            FROM information_schema.columns
                            WHERE table_name = '%s'
                            ''' % (table)
                    type_df = psql.read_sql(query, dev_conn)

                    type_df = type_df[type_df['column_name'] != 'client_server_id']

                    if len(result_df.columns) > len(type_df['column_name']):
                        print('Inconsistent schema. Using merging strategy: %s attributes' % cfg.merge_strat.upper())
                        if cfg.merge_strat == 'drop':
                            type_cols = list(type_df['column_name'])
                            drop_cols = result_df.columns.difference(type_cols)
                            print('Drop columns:', drop_cols)
                            result_df = result_df.drop(columns=drop_cols)
                        elif cfg.merge_strat == 'keep':
                            # to be implemented
                            pass

                    for i in range(len(type_df)):
                        if type_df.iloc[i]['data_type'] in ['integer', 'smallint', 'bigint']:  # and result_df.dtypes.iloc[i] == 'float64':
                            col_name = type_df.iloc[i]['column_name']
                            if col_name in result_df.columns:
                                if result_df[col_name].dtypes == 'float64':
                                    # print('mismatch')
                                    mismatches.add(type_df.iloc[i]['column_name'])
                        # elif type_df.iloc[i]['data_type'] == 'ARRAY':
                        #     query = '''
                        #     select array_to_json(%s)
                        #     from %s
                        #     where pg_xact_commit_timestamp(xmin) < '%s'
                        #     or pg_xact_commit_timestamp(xmin) is null
                        #     ''' % (type_df.iloc[i]['column_name'], table, first_pivot)
                        #     array_df = psql.read_sql(query, dev_conn)
                        #     print(array_df)
                        #     print(array_df[type_df.iloc[i]['column_name']])
                        #     result_df[type_df.iloc[i]['column_name']] = array_df[type_df.iloc[i]['column_name']]

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
                    result_df['client_server_id'] = client_id
                    save_cols = list(result_df.columns)
                    save_cols = ['"%s"' % c for c in save_cols]
                    save_cols = ', '.join(save_cols)

                    # write queries
                    result_df.to_csv('tmp.csv', index=False)
                    with open('tmp.csv', mode='r') as f:
                        next(f)
                        dev_cur.copy_expert('''COPY %s (%s) FROM STDIN WITH (FORMAT CSV)''' % (table, save_cols), f)

                    for col in mismatches:
                        query = '''
                                ALTER TABLE %s
                                ALTER COLUMN %s TYPE integer
                                ''' % (table, col)
                        dev_cur.execute(query)

                    client_cur.close()
                    client_conn.close()

                    pbar.update(1)

                # logging.info('Copy data to s3 bucket')
                # write data to csv then
                # copy data to s3
                # with open('temp.txt', mode='w') as f:
                #     dev_cur.copy_to(f, table, sep='|')
                #
                # s3_file_name = '%s/%s/%s_%s.txt' % (module, table, table, first_pivot.date())
                # logging.debug(s3_file_name)
                # # print(s3_file_name)
                # s3.upload_file('temp.txt', cfg.s3_bucket, s3_file_name)

                with open('temp.csv', mode='w') as f:
                    dev_cur.copy_expert('''COPY %s TO STDOUT WITH (FORMAT CSV)''' % table, f)

                s3_file_name = '%s/%s/%s_%s.csv' % (module, table, table, first_pivot.date())
                logging.debug(s3_file_name)
                # print(s3_file_name)
                s3.upload_file('temp.csv', cfg.s3_bucket, s3_file_name)

                # transfer data to redshift
                # logging.info('Upload data to Redshift')

                # make sure table empty by truncating
                query = '''
                truncate %s
                ''' % table
                redshift_cur.execute(query)

                # copy data from s3 to temp table
                query = '''
                copy %s
                from 's3://%s/%s'
                iam_role '%s'
                region '%s'
                csv
                compupdate on
                ''' % (table, cfg.s3_bucket, s3_file_name, cfg.redshift_iam_role, cfg.redshift_region)
                redshift_cur.execute(query)
                # -- delimiter '|'
                # -- maxerror 2

                # logging.info('Transfer %s table successfully' % table)
                # t_end = time.time()
                # logging.info('Transfer %s table took %s seconds' % (table, round(t_end - t_start)))
                # logging.info('Process took %s seconds so far' % (round(t_end - t_1)))

                dev_conn.commit()
                redshift_conn.commit()

    dev_cur.close()
    dev_conn.close()

    redshift_cur.close()
    redshift_conn.close()

    os.remove('temp.txt') if os.path.exists('temp.txt') else None
    os.remove('temp.csv') if os.path.exists('temp.csv') else None
    os.remove('tmp.csv') if os.path.exists('tmp.csv') else None

    print(error_list)

    error_df = pd.DataFrame.from_records(error_list, columns=('m_i', 'module',
                                                              't_i', 'table',
                                                              'c_i', 'client'))
    error_df.to_csv('errors.csv', index=False)


def transfer_table_client_to_rds(temp_table, table, client, client_conn_pool, client_df, dev_conn,
                                 start_time, end_time):
    '''
    Transfer a single table from client server to rds temp table
    :param temp_table:
    :param table:
    :param client:
    :param client_conn_pool:
    :param client_df:
    :param dev_conn:
    :param dev_cur:
    :param start_time:
    :param end_time:
    :return:
    '''
    client_cur = client_conn_pool[client].cursor()
    dev_cur = dev_conn.cursor()

    query = '''
            SELECT *
            FROM %s
            WHERE pg_xact_commit_timestamp(xmin) >= '%s'
            AND pg_xact_commit_timestamp(xmin) < '%s'
            ''' % (table, start_time, end_time)
    # result_df = restarter(1, psql.read_sql, query, client_conn_pool[client])
    result_df = psql.read_sql(query, client_conn_pool[client])

    if not isinstance(result_df, pd.DataFrame):
        # error_list.append((m_i, module, t_i, table, c_i, client))
        client_cur.close()
        return False

    # if there is no new data, skip the next part
    if len(result_df) == 0:
        client_cur.close()
        dev_cur.close()
        return 'No data'

    # result_df = psql.read_sql(query, client_conn_pool[client])
    logging.debug('Number of updated records: %s' % len(result_df))

    # get column types
    query = '''
            SELECT column_name, data_type
            FROM information_schema.columns
            WHERE table_name = '%s'
            ''' % (temp_table)
    type_df = psql.read_sql(query, dev_conn)

    type_df = type_df[type_df['column_name'] != 'client_server_id']

    # handle extra columns
    # if len(result_df.columns) > len(type_df['column_name']):
    #     logging.info('Inconsistent schema. Using merging strategy: %s extra columns' % merge_strat.upper())
    #     if merge_strat == 'drop':
    #         type_cols = [col_name.replace(entity_mapping[table] + '_', '') for col_name in
    #                      type_df['column_name']]
    #         drop_cols = result_df.columns.difference(type_cols)
    #         logging.debug('Drop columns: %s' % list(drop_cols))
    #         result_df = result_df.drop(columns=drop_cols)
    #     elif merge_strat == 'keep':
    #         # to be implemented
    #         raise NotImplementedError

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
    logging.debug('Mismatches: %s' % list(mismatches))

    # convert to compatible types
    for col in mismatches:
        query = '''
                                ALTER TABLE %s
                                ALTER COLUMN %s TYPE double precision 
                                ''' % (temp_table, col)
        dev_cur.execute(query)

    # add client index
    client_id = int(client_df[client_df['client_name'] == client]['client_id'].iloc[0])
    result_df['client_server_id'] = int(client_id)

    logging.debug('Copy data to temp table')
    # write queries to temp table
    # copy file to s3 (in the future)
    result_df.to_csv('tmp.csv', index=False)
    save_cols = list(result_df.columns)
    save_cols = ['"%s"' % c for c in save_cols]
    save_cols = ', '.join(save_cols)

    with open('tmp.csv', mode='r') as f:
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
    dev_cur.close()


def transfer_table_s3_to_redshift(temp_table, table, redshift_conn, s3_bucket, s3_file_name,
                                  redshift_iam_role, redshift_region):
    '''
    Transfer a single table from s3 to redshift
    :param temp_table:
    :param table:
    :param redshift_cur:
    :param s3_bucket:
    :param s3_file_name:
    :param redshift_iam_role:
    :param redshift_region:
    :return:
    '''

    redshift_cur = redshift_conn.cursor()
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
                        ''' % (temp_table, s3_bucket, s3_file_name, redshift_iam_role, redshift_region)
    redshift_cur.execute(query)

    # delete old records
    query = '''
                        delete from %s
                        where (%s, %s) in (
                            select %s, %s from %s
                        )
                        ''' % (table, 'id', 'client_server_id',
                               'id', 'client_server_id', temp_table)
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

    redshift_cur.close()


def periodic_data_transfer(periodic_mode='daily',
                           start_time='',
                           end_time='',
                           pivot_time='',
                           timezone='Singapore',

                           client_csv='',
                           module_table_meta='',
                           table_client_meta='',

                           unused_modules=(),
                           unused_tables=(),

                           dev_db=None,
                           prod_db=None,
                           redshift_db=None,
                           redshift_iam_role='',
                           redshift_region='',
                           s3_bucket='',

                           verbose=False,
                           verbose_mode='info'):
    '''
    Transfer data between start time and end time
    :param periodic_mode:
    :param start_time:
    :param end_time:
    :param pivot_time:
    :param timezone:
    :param client_csv:
    :param module_table_metadata:
    :param table_client_metadata:
    :param unused_modules:
    :param unused_tables:
    :param dev_db:
    :param prod_db:
    :param redshift_db:
    :param redshift_iam_role:
    :param redshift_region:
    :param s3_bucket:
    :param verbose:
    :param verbose_mode:
    :return:
    '''

    client_df = pd.read_csv(client_csv)
    client_df = client_df[client_df['client_archive'] != 1]

    # initialize all database connections
    dev_conn = pg.connect(**dev_db)
    dev_cur = dev_conn.cursor()
    if dev_conn:
        logging.info('Connect to dev database successfully')

    redshift_conn = pg.connect(**redshift_db)
    redshift_cur = redshift_conn.cursor()
    if redshift_conn:
        logging.info('Connect to Redshift cluster successfully')

    client_conn_pool = {client: pg.connect(**prod_db, database=client)
                        for client in client_df['client_name']}
    if all(client_conn_pool.values()):
        logging.info('Connect to all client servers successfully')

    s3 = boto3.client('s3')

    # get pivot timestamps
    start_time, end_time = get_timerange(periodic_mode, start_time, end_time, pivot_time, timezone)

    # read metadata for looping
    with open(module_table_meta) as f:
        module_table = json.load(f, object_pairs_hook=OrderedDict)
    with open(table_client_meta) as f:
        table_client = json.load(f, object_pairs_hook=OrderedDict)

    checkpoint = False
    checkpoint_table = ''

    # 3 nested loops: module level, table level and client level
    for m_i, module in enumerate(module_table, start=1):
        # filter unused modules
        if module in unused_modules:
            continue

        for t_i, table in enumerate(module_table[module], start=1):
            # filter unused tables
            if table in unused_tables:
                continue
            if table not in table_client:
                continue

            # checkpoint mechanism
            if checkpoint_table:
                if table == checkpoint_table:
                    checkpoint = True
                if not checkpoint:
                    continue

            # create temp table to dump new data
            temp_table = 'temp_' + table
            query = '''
                    create table %s
                    as (select * from %s where 0=1)
                    ''' % (temp_table, table)
            dev_cur.execute(query)

            for c_i, client in enumerate(table_client[table], start=1):
                logging.info('Processing %s module (%s/%s) - %s table (%s/%s) - %s client (%s/%s)'
                             % (module.upper(), m_i, len(module_table),
                                table.upper(), t_i, len(module_table[module]),
                                client.upper(), c_i, len(table_client[table]))
                             )

                transfer_table_client_to_rds(temp_table, table, client, client_conn_pool, client_df,
                                             dev_conn, start_time, end_time)

            logging.debug('Copy data to temp file')
            # write new data to csv
            with open('temp.csv', mode='w') as f:
                dev_cur.copy_expert('''COPY %s TO STDOUT WITH (FORMAT CSV)''' % temp_table, f)

            # transfer data to s3
            s3_file_name = '%s/%s/%s_%s_%s.csv' % (module, table, table,
                                                   start_time.strftime("%Y-%m-%d %H:%M:%S"),
                                                   end_time.strftime("%Y-%m-%d %H:%M:%S"))
            logging.debug(s3_file_name)
            s3.upload_file('temp.csv', s3_bucket, s3_file_name)

            # if there is no new data, skip transferring to redshift
            query = '''
                    select count(*)
                    from %s
                    ''' % temp_table
            dev_cur.execute(query)
            count = dev_cur.fetchone()[0]
            logging.info('Total number of updated rows: %s' % count)

            if count == 0:
                # drop temp table
                query = '''drop table %s''' % temp_table
                dev_cur.execute(query)
                continue

            # load data from temp table to main table
            logging.debug('Load new records into main table')
            # delete old records
            query = '''
                    delete from %s
                    where (%s, %s) in (
                        select %s, %s from %s
                    )
                    ''' % (table, 'id', 'client_server_id',
                           'id', 'client_server_id', temp_table)
            dev_cur.execute(query)

            # insert new records
            query = '''
                        insert into %s
                        select * from %s
                        ''' % (table, temp_table)
            dev_cur.execute(query)

            # drop temp table
            query = '''drop table %s''' % temp_table
            dev_cur.execute(query)

            # transfer data to redshift
            logging.debug('Upload data to Redshift')
            transfer_table_s3_to_redshift(temp_table, table, redshift_conn, s3_bucket, s3_file_name,
                                          redshift_iam_role, redshift_region)

            dev_conn.commit()
            redshift_conn.commit()

    # clean up
    dev_cur.close()
    dev_conn.close()

    redshift_cur.close()
    redshift_conn.close()

    for client in client_conn_pool:
        client_conn_pool[client].close()

    os.remove('tmp.csv')
    os.remove('temp.csv')


if __name__ == '__main__':
    logging.getLogger(__name__)
    logging.basicConfig(level=logging.INFO,
                        format='%(asctime)s %(levelname)s: %(message)s',
                        datefmt='%Y-%m-%d %H:%M:%S')

    with open('config.json') as f:
        cfg = json.load(f, object_pairs_hook=OrderedDict)

    pprint(cfg)

    periodic_data_transfer(periodic_mode=cfg['periodic_mode'],
                           start_time=cfg['start_time'],
                           end_time=cfg['end_time'],
                           pivot_time=cfg['pivot_time'],
                           timezone=cfg['timezone'],

                           client_csv=cfg['client_csv'],
                           module_table_meta=cfg['module_table_meta'],
                           table_client_meta=cfg['table_client_meta'],
                           unused_modules=cfg['unused_modules'],
                           unused_tables=cfg['unused_tables'],

                           dev_db=cfg['dev_db'],
                           prod_db=cfg['client_db'],
                           redshift_db=cfg['redshift_db'],
                           redshift_iam_role=cfg['redshift_iam_role'],
                           redshift_region=cfg['redshift_region'],
                           s3_bucket=cfg['s3_bucket'],
                           )
    # periodic_data_transfer(**cfg)
