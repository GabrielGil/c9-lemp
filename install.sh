#!/bin/bash

# Redirect stdout ( > ) into a named pipe ( >() ) running "tee"
exec > >(tee /tmp/installlog.txt)
# Without this, only stdout would be captured
exec 2>&1

# Update Composer
sudo /usr/bin/composer self-update

# Add PHP7.0 Repository
sudo add-apt-repository ppa:ondrej/php-7.0

# Update Heroku Toolbelt
wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh

# Install PHP7.0
sudo apt-get install php7.0 php7.0-fpm -y
sudo apt-get purge apache2 mysql-server mysql-client -y

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
sudo wget https://raw.githubusercontent.com/sebascontre/c9-lemp/master/c9 --output-document=/etc/nginx/sites-available/c9
sudo chmod 755 /etc/nginx/sites-available/c9
sudo ln -s /etc/nginx/sites-available/c9 /etc/nginx/sites-enabled/c9


# PHP:
sudo sed -i 's/user = www-data/user = ubuntu/g' /etc/php5/fpm/pool.d/www.conf
sudo sed -i 's/group = www-data/group = ubuntu/g' /etc/php5/fpm/pool.d/www.conf
sudo sed -i 's/pm = dynamic/pm = ondemand/g' /etc/php5/fpm/pool.d/www.conf # Reduce number of processes..

# Install helper
sudo wget https://raw.githubusercontent.com/sebascontre/c9-lemp/master/lemp --output-document=/usr/bin/lemp
sudo chmod 755 /usr/bin/lemp

# Start the party!
sudo service nginx start
sudo service nginx reload
sudo service php7.0-fpm start

# Are we ready?
echo Check all services are up.
sleep 5
sudo service nginx status
sudo service php7.0-fpm status
