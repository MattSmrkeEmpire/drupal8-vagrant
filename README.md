# drupal8-vagrant

Set up a clean drupal8 developemnt site using virtualbox + vagrant.

### Install VirtualBox and Vagrant
[VirtualBox](https://www.virtualbox.org/wiki/Downloads)  
[Vagrant](https://www.vagrantup.com/downloads.html)  

### Clone the repo into a new project folder
`git clone git@github.com:matt-smrke/drupal8-vagrant.git your_project_name`  
(or download the zip and change the name to _your_project_name_).

### Edit your hosts file  
On linux or mac, this is the file `/etc/hosts`. Add the line:
```
192.168.44.44   drupal8.local
```  

### Enter the /vagrant folder and start up the vm  
```
cd vagrant  
vagrant up  
```
The first time it starts up it will download the box and install all the dependencies. This takes a little while. Starting up the box afterwards is much quicker.  

### Install and configure your site
Open a browser and go to `http://drupal8.local`. You should see the Drupal8 Installation page. Proceed through the installation, entering the following details for the database:  

**database name:** drupal8  
**database user:** root  
**database password:** root  

You can edit the site files from your regular (host) filesystem in the `docroot` folder.  
When you are done working and want to shut down the vm - go into the `/vagrant` folder and type  
```
vagrant halt
```
When you want to start it up again type  
```
vagrant up
```  
To totally remove the vm  
```
vagrant destroy
```  

That's it. Enjoy!  

****
## Customizing the project
You can change the hostname from `drupal8.local` to any host name you want by making the following changes:  
In `vagrant/hostfile`:  
```
ServerName  your_host.whatever
```
and in `vagrant/provision-trusty64.sh`:  
```
cp /vagrant/hostfile /etc/apache2/sites-available/your_host.conf
a2ensite your_host.conf > /dev/null  
```
and finally, when editing your `/etc/hosts` file, use the same hostname used above:  
```
192.168.44.44  your_host.whatever
```
