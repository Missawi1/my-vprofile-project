FROM mysql:5.7.25
LABEL Project="Vpro"
LABEL Author="Awele Ajiduah"
ADD db_backup.sql /docker-entrypoint-initdb.d/db_backup.sql
EXPOSE 3306
ENV MYSQL_ROOT_PASSWORD="admin123"
ENV MYSQL_DATABASE="accounts"