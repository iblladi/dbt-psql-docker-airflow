FROM quay.io/astronomer/astro-runtime:12.7.1

# install dbt into a venv to avoid package dependency conflicts
WORKDIR "/usr/local/airflow"

# Install Git
RUN apt-get update && apt-get install -y git 

RUN git config --global http.sslVerify false

COPY dbt-requirements.txt ./

RUN python -m virtualenv dbt_venv && \
    /bin/bash -c "source dbt_venv/bin/activate && \
    pip install --trusted-host pip.astronomer.io --no-cache-dir -r dbt-requirements.txt && \
    deactivate"

#RUN python -m virtualenv dbt_venv && source dbt_venv/bin/activate && \
#    pip install --no-cache-dir -r dbt-requirements.txt && deactivate