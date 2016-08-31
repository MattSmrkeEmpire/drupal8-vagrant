#!/usr/bin/env bash

# Intended for Ubuntu 14.04 (Trusty)

# Adjust timezone to be Toronto
sudo ln -sf /usr/share/zoneinfo/America/Toronto /etc/localtime


# Install Apache, PHP
echo "Updating repositories"
sudo apt-get install software-properties-common python-software-properties build-essential -y > /dev/null
sudo add-apt-repository ppa:ondrej/php -y > /dev/null
sudo apt-get update > /dev/null

echo "----- Installing Apache, PHP and MySQL"
sudo apt-get install apache2 php5.6 libapache2-mod-php5.6 -y > /dev/null
sudo echo "ServerName localhost" > "/etc/apache2/conf-available/fqdn.conf"
sudo a2enconf fqdn > /dev/null
sudo a2enmod rewrite > /dev/null
sudo a2dissite 000-default.conf > /dev/null


echo "Installing PHP extensions and utils"
sudo apt-get install curl php5.6-curl php5.6-gd php5.6-mcrypt php5.6-mysql php5.6-dom -y  > /dev/null
sudo apt-get install debconf-utils -y > /dev/null


# Cleanup
sudo apt-get -y autoremove > /dev/null

# Set up Apache
echo "----- Finishing Apache setup ..."
sudo rm -rf /var/www/html
sudo rm /etc/apache2/envvars
sudo cp /vagrant/apache-envvars /etc/apache2/envvars
sudo service apache2 restart > /dev/null

# Composer
echo "---- Installing Composer and Drush ..."
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
sudo composer global require drush/drush
sudo ln -s ~/.composer/vendor/drush/drush/drush /usr/local/bin/drush

# Drupal Console
echo "----- Installing Drupal Console..."
curl https://drupalconsole.com/installer -L -o drupal.phar
sudo mv drupal.phar /usr/local/bin/drupal
sudo chmod +x /usr/local/bin/drupal
drupal init --override


echo "--- All Done!"







