import airflow
from airflow.settings import Session
from airflow.models import DAG
from airflow.operators.python_operator import PythonOperator
from airflow.operators.dummy_operator import DummyOperator

from modules.db_integration_to_s3.daily_migration import individual_company_migration, describe_all_instances, \
    logger, TABLE_TAGS

from datetime import timedelta


def subdag_factory(parent_dag_name, child_dag_name, start_date, schedule_interval, default_args, parent_dag=None):
    """
    To encompass breaking down of tasks with one connection per company database.
    """
    subdag = DAG(
        dag_id='{0}.{1}'.format(parent_dag_name, child_dag_name),
        schedule_interval=schedule_interval,
        start_date=start_date,
        default_args=default_args,
        catchup=False)


    with subdag:
        db_dictionary = describe_all_instances()
        
        dbs = db_dictionary.keys()
        logger.info("Instances List: %s" % dbs)

        for db_item in db_dictionary.values():
            # First index is the db instance details
            db = db_item[0]

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

            # Second index is the database names.
            database_names = db_item[1]

            logger.info("Databases List: %s" % database_names)

            # We create one task for one database is better, so we don't overload the number of connections to the databases.
            for database_name in database_names:
                task_id = "%s_%s" % ("migration_", database_name)

                migration_task = PythonOperator(
                    task_id=task_id,
                    python_callable=individual_company_migration,
                    op_kwargs={
                        'instance_details' : db,
                        'database_name' : database_name,
                        'table_filters' : TABLE_TAGS
                    },
                    default_args=default_args,
                    dag=subdag
                )

        return subdag
