import airflow
from airflow.models import DAG
from airflow.operators.python_operator import PythonOperator
from airflow.operators.dummy_operator import DummyOperator

from modules.db_integration_to_rds.data_pipeline import periodic_data_transfer as centralizedrds_pipeline_daily

from datetime import datetime
from datetime import timedelta

"""
This script would be used to orchestrate all activities in the k8 container 
using airflow to schedule and sequence every task in place.
"""

##############################################################################################################################
# Daily DAG Pipeline ---------------------------------------------------------------------------------------------------------
PARENT_DAG_NAME = 'daily_redshift_pipeline'

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

   # ------------ REDSHIFT TASK ------------------------    
    daily_rds_task = PythonOperator(
        task_id = 'rds_redshift_pipeline',
        python_callable = centralizedrds_pipeline_daily
    )

    end_task = DummyOperator(
        task_id = 'end_daily_pipeline'
    )

    start_task >> daily_rds_task >> end_task