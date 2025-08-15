#!/bin/bash
set -e

sleep 15

wget https://fr.wordpress.org/wordpress-6.7.3-fr_FR.tar.gz -P /var/www/html
cd /var/www/html

tar -xzf wordpress-6.7.3-fr_FR.tar.gz --strip-components=1
rm wordpress-6.7.3-fr_FR.tar.gz

chown -R root:root /var/www/html

wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

cd /var/www/html

mkdir -p /run/php

if [ -f /var/www/html/wp-config.php ]; then
  echo "wp-config.php already installed, running..."
else
  wp config create \
    --dbname="${MYSQL_DATABASE}" \
    --dbuser="${MYSQL_USER}" \
    --dbpass="${MYSQL_PASSWORD}" \
    --dbhost="mariadb:3306" \
    --path=/var/www/html \
    --allow-root

  wp core install \
    --url="https://hadubois.42.fr" \
    --title="${WP_TITLE}" \
    --admin_user="${WP_ADM_USER}" \
    --admin_password="${WP_ADM_PASSWD}" \
    --admin_email="${WP_ADM_EMAIL}" \
    --path=/var/www/html \
    --allow-root
fi

/usr/sbin/php-fpm7.4 -R -F
