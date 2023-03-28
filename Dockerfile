FROM timescale/timescaledb-ha:pg15.2-ts2.10.1-oss-p2

USER 0

ENV DEBIAN_FRONTEND=noninteractive

# 安裝額外的工具
RUN apt update


# 安裝 pg_cron
RUN apt-get install -y postgresql-15-cron; apt-get clean
RUN rm -rf /var/lib/apt/lists/*

COPY 002_setup-postgres.sh /docker-entrypoint-initdb.d/
# 設置環境變量
ENV POSTGRES_USER postgres
ENV POSTGRES_PASSWORD postgres
ENV POSTGRES_DB mydb

# 將 pg_cron 安裝腳本加入容器中
COPY create_extension.sh /docker-entrypoint-initdb.d/

# 暴露 PostgreSQL 和 TimescaleDB 的預設端口
EXPOSE 5432
