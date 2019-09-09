import airflow
from airflow.models import DAG
from airflow.operators.python_operator import PythonOperator
from airflow.operators.dummy_operator import DummyOperator

from modules.db_integration_to_rds.auto_transfer import handler as centralizedrds_pipeline_daily
from modules.db_integration_to_s3.daily_migration import describe_all_instances, individual_company_migration, TABLE_TAGS

from datetime import datetime
from datetime import timedelta

"""
This script would be used to orchestrate all activities in the k8 container 
using airflow to schedule and sequence every task in place.
"""

##############################################################################################################################
# Daily DAG Pipeline ---------------------------------------------------------------------------------------------------------
PARENT_DAG_NAME = 'daily_etl_pipeline'
S3_SUBDAG_NAME = 's3_pipeline'

start_date = datetime.strptime('2019-09-09', '%Y-%m-%d')

default_args = {
    'owner': 'airflow',
    'start_date': start_date,
    'depends_on_past': False,
    'email': ['dongyang@hubble.sg'],
    'email_on_failure': True,
    'email_on_retry': False,
    'email_on_success': False,
    'retries': 3,
    'retry_delay': timedelta(minutes=5),
    'catchup': False
}

with DAG(
    dag_id = PARENT_DAG_NAME,
    description = 'This pipeline is to encapsulate all pipelines needed to run daily.',
    default_args = default_args,
    # We are running at 4pm as the timezone is set to be UTC by default - this translates to 12am in SGT.
    schedule_interval = '0 16 * * *',
) as dag:

    start_task = DummyOperator(
        task_id = 'start_of_daily_pipeline'
    )

    end_task = DummyOperator(
        task_id = 'end_daily_pipeline'
    )
    
    # ------------ S3 TASK ------------------------------  
    db_dictionary = describe_all_instances()
    dbs = db_dictionary.keys()

    for db_item in db_dictionary.values():
        # First index is the db instance details
        db = db_item[0]

        instance = db['DBInstanceIdentifier']
        dbuser = db['MasterUsername']
        endpoint = db['Endpoint']
        host = endpoint['Address']
        port = endpoint['Port']
        location = str(db['DBInstanceArn'].split(':')[3])

        # Second index is the database names.
        database_names = db_item[1]

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
                }
            )
            start_task >> migration_task >> end_task