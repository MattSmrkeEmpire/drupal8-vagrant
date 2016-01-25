#!/usr/bin/env bash

# Intended for Ubuntu 14.04 (Trusty)

# Adjust timezone to be Toronto
ln -sf /usr/share/zoneinfo/America/Toronto /etc/localtime


# Install Apache, PHP
echo "Updating repositories"
apt-get install software-properties-common python-software-properties build-essential -y > /dev/null
add-apt-repository ppa:ondrej/php5 -y > /dev/null
apt-get update > /dev/null

echo "----- Installing Apache, PHP and MySQL"
apt-get install apache2 php5 libapache2-mod-php5 -y > /dev/null
echo "ServerName localhost" > "/etc/apache2/conf-available/fqdn.conf"
a2enconf fqdn > /dev/null
a2enmod rewrite > /dev/null
a2dissite 000-default.conf > /dev/null


echo "Installing PHP extensions"
apt-get install curl php5-curl php5-gd php5-mcrypt php5-mysql -y  > /dev/null


echo "Installing MySQL"
apt-get install debconf-utils -y > /dev/null
debconf-set-selections <<< "mysql-server mysql-server/root_password password root"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password root"
apt-get install mysql-server -y > /dev/null


mysql -uroot -proot -e "CREATE DATABASE IF NOT EXISTS drupal8"


# Apache / Virtual Host Setup
echo "----- Provision: Install Host File..."
cp /vagrant/hostfile /etc/apache2/sites-available/drupal8.conf
a2ensite drupal8.conf > /dev/null

rm -rf /var/www/html

# Cleanup
apt-get -y autoremove > /dev/null

# Restart Apache
echo "----- Restarting Apache..."
service apache2 restart > /dev/null

echo "--- All Done!"
