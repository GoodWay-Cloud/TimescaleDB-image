-- 切換到 database
\c mydb

-- 安裝 pg_cron 擴展
CREATE EXTENSION IF NOT EXISTS pg_cron;
CREATE EXTENSION IF NOT EXISTS pg_stat_statements;
