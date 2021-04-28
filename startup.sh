#!/bin/#!/usr/bin/env bash


sudo chown www-data /etc/apache2/sites-available/kimai.conf
sudo a2dissite 000-default
sudo a2ensite kimai
sudo service apache2 restart
