#!/bin/bash

sudo mkdir /railpage
sudo chown vagrant:vagrant /railpage

sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password vagrant'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password vagrant'

echo [client]>  ~/.my.cnf
echo user=root>> ~/.my.cnf
echo password=vagrant>> ~/.my.cnf

git clone https://github.com/railpage/railpagecore.git /railpage/railpagecore
sudo apt-get -q -y update >> /railpage/setup.log
sudo apt-get -q -y install mysql-server php5 php5-cli php5-curl php5-json php5-gd php5-dev php5-memcache php5-memcached php5-redis php5-xdebug php5-xhprof memcached >> /railpage/setup.log

curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

wget https://phar.phpunit.de/phpunit.phar
chmod +x phpunit.phar
sudo mv phpunit.phar /usr/local/bin/phpunit

mysql -u root --password=vagrant -e "create database sparta_unittest; grant all on sparta_unittest.* to 'travis'@'localhost'";