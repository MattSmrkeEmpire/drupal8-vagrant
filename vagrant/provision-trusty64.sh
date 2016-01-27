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


echo "Installing PHP extensions and utils"
apt-get install curl php5-curl php5-gd php5-mcrypt php5-mysql -y  > /dev/null
apt-get install debconf-utils -y > /dev/null


# Cleanup
apt-get -y autoremove > /dev/null

# Set up Apache
echo "----- Finishing Apache setup ..."
rm -rf /var/www/html
rm /etc/apache2/envvars
cp /vagrant/apache-envvars /etc/apache2/envvars
service apache2 restart > /dev/null

# Drupal Console
echo "----- Installing Drupal Console..."
curl https://drupalconsole.com/installer -L -o drupal.phar
mv drupal.phar /usr/local/bin/drupal
chmod +x /usr/local/bin/drupal
drupal init --override


echo "--- All Done!"







