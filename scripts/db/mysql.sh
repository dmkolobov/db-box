#!/bin/bash

source /vagrant/scripts/util.sh 

load_proxy 

debconf-set-selections <<< "mysql-community-server mysql-community-server/root-pass password vagrant"
debconf-set-selections <<< "mysql-community-server mysql-community-server/re-root-pass password vagrant"
DEBIAN_FRONTEND=noninteractive apt-get -y install mysql-server-5.7

sed -i '/skip-external-locking/d' /etc/mysql/mysql.conf.d/mysqld.cnf
sed -i '/bind-address/d' /etc/mysql/mysql.conf.d/mysqld.cnf

service mysql restart

mysql -u root --password="vagrant" --execute="grant all on *.* to 'vagrant'@'%' identified by 'vagrant';
                                              create database vagrant;"