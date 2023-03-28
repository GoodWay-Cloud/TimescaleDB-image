FROM timescale/timescaledb-postgis:latest-pg12

# 安裝額外的工具
RUN apk update

# 安裝必要的套件
RUN apk add --no-cache build-base postgresql-dev git

# 安裝 pg_cron
RUN git clone https://github.com/citusdata/pg_cron.git && \
    cd pg_cron && \
    make install && \
    cd .. && \
    rm -rf pg_cron

COPY 002_setup-postgres.sh /docker-entrypoint-initdb.d/
# 設置環境變量
ENV POSTGRES_USER postgres
ENV POSTGRES_PASSWORD postgres
ENV POSTGRES_DB mydb

# 將 pg_cron 安裝腳本加入容器中
COPY install_pg_cron.sh /docker-entrypoint-initdb.d/

# 暴露 PostgreSQL 和 TimescaleDB 的預設端口
EXPOSE 5432
