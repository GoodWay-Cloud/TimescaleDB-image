#!/bin/bash

# 在 postgres.conf 中寫入您需要的變數
echo "shared_preload_libraries = 'timescaledb,pg_cron,pg_stat_statements'" >> ${PGDATA}/postgresql.conf
echo "cron.database_name = '${POSTGRES_DB:-postgres}'" >> ${PGDATA}/postgresql.conf
echo "compute_query_id = on" >> ${PGDATA}/postgresql.conf
echo "pg_stat_statements.max = 10000" >> ${PGDATA}/postgresql.conf
echo "pg_stat_statements.track = all" >> ${PGDATA}/postgresql.conf


pg_ctl restart 
