#!/bin/#!/usr/bin/env bash


cd /var/www/kimai2
bin/console kimai:install -n
chown -R :www-data .
chmod -R g+r .
chmod -R g+rw var/
chmod -R g+rw public/avatars/
apache2-foreground
