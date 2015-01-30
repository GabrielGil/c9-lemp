#!/bin/bash



# Redirect stdout ( > ) into a named pipe ( >() ) running "tee"
exec > >(tee /tmp/installlog.txt)
# Without this, only stdout would be captured
exec 2>&1



# Stop all the services

# Apache2
sudo service apache2 stop
# NGINX
sudo service nginx stop
# MySQL
mysql-ctl stop



# Set them up!


# NGINX:
# Listen port 80, change document root, setup indexes, configure PHP sock
# set up the try_url thing (Drupal is not Worpress)...
# Thankfully, I already modified this in the repo!
sudo wget https://raw.githubusercontent.com/GabrielGil/c9-lemp/master/default --output-document=/etc/nginx/sites-available/default

# PHP:
sudo sed -i 's/user = www-data/user = ubuntu/g' /etc/php5/fpm/pool.d/www.conf
sudo sed -i 's/group = www-data/group = ubuntu/g' /etc/php5/fpm/pool.d/www.conf

# MySQL:
mysql-ctl install



# Start the party!
mysql-ctl start
sudo service nginx start
sudo service php5-fpm start



# Are we ready?
echo Check all services are up.
sleep 5 # Wait for MySQL server to be fully loaded.
sudo service nginx status
sudo service php5-fpm status
mysql-ctl status