#!/bin/bash

# Redirect stdout ( > ) into a named pipe ( >() ) running "tee"
exec > >(tee /tmp/installlog.txt)
# Without this, only stdout would be captured
exec 2>&1

# Check if sources.list is a symlink and make a copy so `apt-get update` succeeds
if [ -f /etc/apt/sources.list ] && [ -L /etc/apt/sources.list ]; then
  sudo mv /etc/apt/sources.list /etc/apt/sources.list.old
  sudo cp /etc/apt/sources.list.old /etc/apt/sources.list
fi

# Stop all the services

# Apache2
sudo service apache2 stop
# NGINX
sudo service nginx stop

# Update Composer
sudo /usr/bin/composer self-update

# Add PHP Repository and Redis Repository
LC_ALL=C.UTF-8 sudo add-apt-repository ppa:ondrej/php -y
sudo add-apt-repository ppa:chris-lea/redis-server -y
sudo apt-get update

# Update Heroku Toolbelt
wget -qO- https://cli-assets.heroku.com/install-ubuntu.sh | sh

# Install PHP7.0 & Redis
sudo apt-get install -qq php7.2-fpm php7.2-cli php7.2-common php7.2-json php7.2-opcache php7.2-mysql php7.2-phpdbg \
php7.2-mbstring php7.2-gd php7.2-imap php7.2-ldap php7.2-pgsql php7.2-pspell php7.2-recode php7.2-tidy php7.2-dev \
php7.2-intl php7.2-gd php7.2-curl php7.2-zip php7.2-xml redis-server
sudo apt-get purge -qq apache2 mysql-server mysql-client

# Set them up!

# NGINX:
# Listen port 80, change document root, setup indexes, configure PHP sock
# set up the try_url thing (Drupal is not Worpress)...
# Thankfully, I already modified this in the repo!
sudo wget https://raw.githubusercontent.com/GabrielGil/c9-lemp/master/c9 --output-document=/etc/nginx/sites-available/c9
sudo chmod 755 /etc/nginx/sites-available/c9
sudo ln -s /etc/nginx/sites-available/c9 /etc/nginx/sites-enabled/c9


# PHP:
sudo sed -i 's/user = www-data/user = ubuntu/g' /etc/php/7.2/fpm/pool.d/www.conf
sudo sed -i 's/group = www-data/group = ubuntu/g' /etc/php/7.2/fpm/pool.d/www.conf
sudo sed -i 's/pm = dynamic/pm = ondemand/g' /etc/php/7.2/fpm/pool.d/www.conf # Reduce number of processes..

# Install Redis Driver
cd ~
git clone https://github.com/phpredis/phpredis.git
cd phpredis
#git checkout php7 #Not Working!
phpize
./configure
make && sudo make install
cd ..
rm -rf phpredis
sudo sh -c 'echo "extension=redis.so" > /etc/php/7.2/mods-available/redis.ini'
sudo ln -sf /etc/php/7.2/mods-available/redis.ini /etc/php/7.2/fpm/conf.d/20-redis.ini
sudo ln -sf /etc/php/7.2/mods-available/redis.ini /etc/php/7.2/cli/conf.d/20-redis.ini

# Install helper
sudo wget https://raw.githubusercontent.com/GabrielGil/c9-lemp/master/lemp --output-document=/usr/bin/lemp
sudo chmod 755 /usr/bin/lemp

# Start the party!
sudo service nginx start
sudo service nginx reload
sudo service php7.2-fpm start

# Are we ready?
echo Check all services are up.
sleep 5
sudo service nginx status
sudo service php7.2-fpm status
lemp restart
