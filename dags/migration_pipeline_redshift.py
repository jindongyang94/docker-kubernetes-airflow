import airflow
from airflow.models import DAG
from airflow.operators.python_operator import PythonOperator
from airflow.operators.dummy_operator import DummyOperator

from db_migration.db_migration_to_rds.data_pipeline import get_daily_timerange, parse_config, transfer_module

from datetime import datetime
from datetime import timedelta
import json
from collections import OrderedDict

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
        task_id = 'start_of_redshift_pipeline'
    )

    end_task = DummyOperator(
        task_id = 'end_of_redshift_pipeline'
    )

    # ------------ REDSHIFT TASK ------------------------
    config_path = "./modules/db_migration/db_migration_lib/config.json"
    cfg = parse_config(config_path)
    start_time, end_time = get_daily_timerange(cfg['pivot_time'], cfg['timezone'])
    
    with open("./modules/db_migration/db_migration_to_rds/metadata/table_module_mapping.json") as f:
        module_table = json.load(f, object_pairs_hook=OrderedDict)

    for module in module_table:
        if module in cfg['unused_modules']:
            continue  
        
        task_id = "%s_%s" % ("migration_", module)

        daily_redshift_task = PythonOperator(
            task_id = task_id,
            python_callable = transfer_module,
            op_kwargs={
                'cfg': cfg,
                'module': module,
                'start_time': start_time,
                'end_time': end_time
            }
        )
        start_task >> daily_redshift_task >> end_task
