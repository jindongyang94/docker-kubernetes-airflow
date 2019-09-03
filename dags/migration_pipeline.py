import airflow
from airflow.models import DAG
from airflow.operators.python_operator import PythonOperator
from airflow.operators.dummy_operator import DummyOperator

from modules.db_integration_to_rds.auto_transfer import handler as centralizedrds_pipeline_daily
from modules.db_integration_to_s3.daily_migration import handler as s3_pipeline_daily
from modules.db_integration_to_s3.periodic_dump import handler as s3_pipeline_periodic

from datetime import timedelta

"""
This script would be used to orchestrate all activities in the k8 container 
using airflow to schedule and sequence every task in place.
"""

##############################################################################################################################
# Daily DAG Pipeline ---------------------------------------------------------------------------------------------------------

default_args = {
    'owner': 'airflow',
    'start_date': airflow.utils.dates.days_ago(0),
    'depends_on_past': False,
    'email': ['dongyang@hubble.sg'],
    'email_on_failure': True,
    'email_on_retry': False,
    'retries': 3,
    'retry_delay': timedelta(minutes=5)
}

with DAG(
    dag_id = 'daily_pipeline_service',
    description = 'This pipeline is to instantiate both daily pipelines at one go.',
    default_args = default_args,
    # We are running at 4pm as the timezone is set to be UTC by default - this translates to 12am in SGT.
    schedule_interval = '0 16 * * *',
) as dag:

    t0 = DummyOperator(
        task_id = 'start_of_daily_pipeline'
    )
        
    t1a_daily_rds = PythonOperator(
        task_id = 'daily_rds_to_rds_to_redshift_pipeline',
        # provide_context = True,
        python_callable = centralizedrds_pipeline_daily
    )

    t1b_daily_s3 = PythonOperator(
        task_id = 'daily_rds_to_s3_pipeline',
        # provide_context = True,
        python_callable = s3_pipeline_daily
    )

    t0 >> [t1a_daily_rds, t1b_daily_s3]

########################################################################################################################
# Periodic (Monthly) DAG Pipeline -----------------------------------------------------------------------------------