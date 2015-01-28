#!/bin/bash -e
set -e

# Redirect stdout ( > ) into a named pipe ( >() ) running "tee"
exec > >(tee /tmp/installlog.txt)

# Without this, only stdout would be captured - i.e. your
# log file would not contain any error messages.
exec 2>&1

#
# Stop all the services
#

# Apache2
sudo service apache2 status
sudo service apache2 stop
sudo service apache2 status

# NGINX
sudo service nginx status
sudo service nignx stop
sudo service nginx status

# MySQL
mysql-ctl status
mysql-ctl stop
mysql-ctl status

# Set Up PHP
sudo sed -i 's/user = www-data/user = ubuntu/g' /etc/php5/fpm/pool.d/www.conf
sudo sed -i 's/group = www-data/user = ubuntu/g' /etc/php5/fpm/pool.d/www.conf

# Set up MySQL
mysql-ctl install

# Set up NGINX
# Listen port 80,

# Setup indexes

# Configure PHP sock

# Set up the try_url thing

# Location...
ls -l /etc/nginx/sites-available/

# Start the party!
sudo service nginx start
sudo service php5-fpm start
mysql-ctl restart

# Are we ready?
sudo service nginx status
sudo service php5-fpm status
mysql-ctl status