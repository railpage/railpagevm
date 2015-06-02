#!/bin/bash

sudo mkdir /railpage
sudo chown vagrant:vagrant /railpage

sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password vagrant'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password vagrant'

echo stdout for some tasks redirected to /railpage/setup.log

git clone https://github.com/railpage/railpagecore.git /railpage/railpagecore
sudo apt-get -q -y update >> /railpage/setup.log
sudo apt-get -q -y install mysql-server php5 php5-cli php5-curl php5-mysql php5-json php5-gd php5-dev php5-memcache php5-memcached php5-redis php5-xdebug php5-xhprof memcached redis-server >> /railpage/setup.log

curl -sS https://getcomposer.org/installer | php 
sudo mv composer.phar /usr/local/bin/composer

wget https://phar.phpunit.de/phpunit.phar >> /railpage/setup.log
chmod +x phpunit.phar
sudo mv phpunit.phar /usr/local/bin/phpunit

echo [client]>  ~/.my.cnf
echo user=root>> ~/.my.cnf
echo password=vagrant>> ~/.my.cnf

mysql -u root --password=vagrant -e "create database sparta_unittest"
mysql -u root --password=vagrant -e "grant all on sparta_unittest.* to 'travis'@'localhost'";

cd /railpage/railpagecore
sudo chown vagrant:vagrant /railpage/railpagecore
composer update >> /railpage/setup.log
sudo chown -R vagrant:vagrant .
sudo composer clearcache

echo Alias /railpagecore /railpage/railpagecore/build/logs/html > ~/railpagecore.conf
echo \<Directory /railpage/railpagecore/build/logs/html\> >> ~/railpagecore.conf
echo Require all granted >> ~/railpagecore.conf
echo \</Directory\> >> ~/railpagecore.conf
sudo mv ~/railpagecore.conf /etc/apache2/conf-enabled/railpagecore.conf
sudo service apache2 reload

echo Running PHPUnit - results available at http://\<ipaddr\>/railpagecore/
./phpunit.sh -c html -p 5
