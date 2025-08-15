#!/bin/bash
#   MYSQL_ROOT_PASSWORD=rootpassword
#   MYSQL_PASSWORD=password
#   MYSQL_USER=user
#   MYSQL_DATABASE=mariadb

set -e

FLAG="/var/lib/mysql/flag_file"

service mariadb start

sleep 5

if [ -f "${FLAG}" ]; then
    echo "mariadb already install, running..."
else
    mysql -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
    mysql -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
    mysql -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%'; FLUSH PRIVILEGES;"
    mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}'; FLUSH PRIVILEGES;"

    touch ${FLAG}
fi
mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown
exec mysqld_safe