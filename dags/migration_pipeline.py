import airflow
from airflow.models import DAG
from airflow.operators.python_operator import PythonOperator
from airflow.operators.dummy_operator import DummyOperator
from airflow.operators.subdag_operator import SubDagOperator
from airflow.executors.local_executor import LocalExecutor

from modules.db_integration_to_rds.auto_transfer import handler as centralizedrds_pipeline_daily
from modules.db_integration_to_s3.daily_migration import describe_all_instances
from subdags.subdag_migration_s3 import subdag_factory as subdag_s3


from datetime import timedelta

"""
This script would be used to orchestrate all activities in the k8 container 
using airflow to schedule and sequence every task in place.
"""

##############################################################################################################################
# Daily DAG Pipeline ---------------------------------------------------------------------------------------------------------
PARENT_DAG_NAME = 'daily_etl_pipeline'
S3_SUBDAG_NAME = 's3_pipeline'

default_args = {
    'owner': 'airflow',
    'start_date': '2019-09-06',
    'depends_on_past': False,
    'email': ['dongyang@hubble.sg'],
    'email_on_failure': True,
    'email_on_retry': False,
    'email_on_success': False,
    'retries': 3,
    'retry_delay': timedelta(minutes=5)
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
        
    daily_rds_task = PythonOperator(
        task_id = 'rds_redshift_pipeline',
        # provide_context = True,
        python_callable = centralizedrds_pipeline_daily
    )

    daily_s3_task = SubDagOperator(
        task_id = S3_SUBDAG_NAME,
        subdag = subdag_s3(PARENT_DAG_NAME, S3_SUBDAG_NAME, dag.start_date, dag.schedule_interval, dag.default_args, \
            parent_dag=dag),
        executor= LocalExecutor(),
        default_args=default_args
    )

    end_task = DummyOperator(
        task_id = 'end_daily_pipeline'
    )

    start_task >> [daily_rds_task, daily_s3_task]
    [daily_rds_task, daily_s3_task] >> end_task