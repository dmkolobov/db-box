#!/bin/bash

source /vagrant/scripts/util.sh

load_proxy

if [ ! -f /etc/apt/sources.list.d/pgdg.list ]; then
    echo 'deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main' > /etc/apt/sources.list.d/pgdg.list 
fi

wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - 
apt-get update 

apt-get -y install postgresql-9.6

sudo -u postgres createdb vagrant 
sudo -u postgres psql -d vagrant -c "create user vagrant with password 'vagrant';"
sudo -u postgres psql -d vagrant -c "grant all privileges on database vagrant to vagrant;"

# ensure postgres starts on boot
update-rc.d postgresql enable

# allow connections from outside
echo "listen_addresses = '*'" >> /etc/postgresql/9.6/main/postgresql.conf
echo "host all all 0.0.0.0/0 md5" >> /etc/postgresql/9.6/main/pg_hba.conf

# restart postgres 
/etc/init.d/postgresql restart