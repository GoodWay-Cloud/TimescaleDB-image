#!/bin/bash

# 在 postgres.conf 中寫入您需要的變數
echo "shared_preload_libraries = 'timescaledb,pg_cron'" >> ${PGDATA}/postgresql.conf
echo "cron.database_name = '${POSTGRES_DB:-postgres}'" >> ${PGDATA}/postgresql.conf

pg_ctl restart 