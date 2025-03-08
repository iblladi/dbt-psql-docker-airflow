import os
from datetime import datetime

from cosmos import DbtDag, ProjectConfig, ProfileConfig, ExecutionConfig
#from cosmos.profiles import PostgresUserPasswordProfileMapping


#profile_config = ProfileConfig(
#    profile_name="trainingdbt",
#    target_name="dev",
#    profile_mapping=PostgresUserPasswordProfileMapping(
#        conn_id="postgres_conn", 
#        profile_args={"database": "postgres", "schema": "public"},
#    )
#)

profile_config = ProfileConfig(
    profiles_yml_filepath="/usr/local/airflow/dbt/employee/profiles.yml",  # Path to your profiles.yml
    profile_name="trainingdbt",  # Name of the profile in your profiles.yml
    target_name="dev",    # Target in your profile (e.g., dev, prod)
)


dbt_snowflake_dag = DbtDag(
    project_config=ProjectConfig("/usr/local/airflow/dbt/employee",),
    operator_args={"install_deps": True},
    profile_config=profile_config,
    execution_config=ExecutionConfig(dbt_executable_path=f"{os.environ['AIRFLOW_HOME']}/dbt_venv/bin/dbt",),
    schedule_interval="@daily",
    start_date=datetime(2025, 3, 7),
    catchup=False,
    dag_id="employee_dag",
)