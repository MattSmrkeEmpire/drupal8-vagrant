#!/bin/bash

# Move the settings.php
#chmod 755 sites/default
#chmod 755 sites/default/settings.php
#mv sites/default/settings.php sites/default/settings.tmp.php
site_name='droop8'
db_name='drupal8db'

# Drop any existing database so site-install doesn't choke on foreign key constraints.
ssh vagrant@drupal8.local 'mysql -u root -proot -e "DROP DATABASE IF EXISTS drupal8db"'

# Install Drupal virgin version
echo Site name will be ${site_name}
drush @d8 site-install standard -y --account-name=dev --account-pass=dev --db-url=mysql://root:root@localhost/${db_name} --site-name=${site_name}

# Restore settings.php
#chmod 755 sites/default
#chmod 755 sites/default/settings.php
#rm -f sites/default/settings.php
#mv sites/default/settings.tmp.php sites/default/settings.php

# Install/Run empire_general module
#drush @ff pm-enable --strict=0 empire_general -y

#Change permission for files system
#chmod -R 777 sites/default/files
#Set the .htaccess file permission.
#chmod 644 sites/default/files/private/.htaccess

# Show dpm to all users
#drush @ff en devel -y
#drush @ff en -y simpletest
#drush @ff rap 'anonymous user' 'access devel information'

#drush @ff user-create user555 --mail="user555@test-empire.ca" --password="user555"
#drush @ff urol "advisor" --name=user555

# Clear Drupal cache - done in above command
#drush @ff cc all
