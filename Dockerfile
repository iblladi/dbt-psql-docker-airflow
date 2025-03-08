FROM quay.io/astronomer/astro-runtime:12.7.1
# install dbt into a venv to avoid package dependency conflicts
WORKDIR "/usr/local/airflow"

COPY dbt-requirements.txt ./

# Set environment variables
ENV DB_HOST=host.docker.internal

USER root

RUN apt-get update && apt-get install -y git && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Git
#RUN apt-get update && apt-get install -y git

# Disable SSL verification
#RUN git config --global http.sslVerify false

RUN python -m virtualenv dbt_venv && source dbt_venv/bin/activate && \
    pip install --no-cache-dir -r dbt-requirements.txt && deactivate