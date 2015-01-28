#!/bin/bash
#set -e

# Redirect stdout ( > ) into a named pipe ( >() ) running "tee"
exec > >(tee /tmp/installlog.txt)

# Without this, only stdout would be captured - i.e. your
# log file would not contain any error messages.
exec 2>&1

#
# Stop all the services
#

# Apache2
sudo service apache2 stop

# NGINX
sudo service nignx stop

# MySQL
mysql-ctl stop

# Set Up PHP
sudo sed -i 's/user = www-data/user = ubuntu/g' /etc/php5/fpm/pool.d/www.conf
sudo sed -i 's/group = www-data/group = ubuntu/g' /etc/php5/fpm/pool.d/www.conf

# Set up MySQL
mysql-ctl install

# Set up NGINX
# Listen port 80, change document root, setup indexes, configure PHP sock
# set up the try_url thing (Drupal is not Worpress)...
# Thankfully, I already modified this in the repo!
sudo wget https://raw.githubusercontent.com/GabrielGil/c9-lemp/master/default --output-document=/etc/nginx/sites-available/default

# Start the party!
sudo service nginx start
sudo service php5-fpm start
mysql-ctl restart

# Are we ready?
sudo service nginx status
sudo service php5-fpm status
mysql-ctl status