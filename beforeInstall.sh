#!/bin/bash

rm /etc/apache2/sites-enabled/000-default.conf
sed -i "s/%USERNAME%/$USERNAME/" /var/www/kimai2/.env
sed -i "s/%PASSWORD%/$PASSWORD/" /var/www/kimai2/.env
sed -i "s/%DB_NAME%/$DB_NAME/" /var/www/kimai2/.env
sed -i "s/%DB_PORT%/$DB_PORT/" /var/www/kimai2/.env
sed -i "s/%DB_HOST%/$DB_HOST/" /var/www/kimai2/.env
