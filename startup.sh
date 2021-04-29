#!/bin/#!/usr/bin/env bash


cd /var/www/kimai2
sed -i "s/%USERNAME%/$USERNAME/" .env
sed -i "s/%PASSWORD%/$PASSWORD/" .env
sed -i "s/%DB_NAME%/$DB_NAME/" .env
sed -i "s/%DB_PORT%/$DB_PORT/" .env
sed -i "s/%DB_HOST%/$DB_HOST/" .env
bin/console kimai:install -n
apachectl-foreground
