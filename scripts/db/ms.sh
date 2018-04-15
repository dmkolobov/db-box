#!/bin/bash 

source /vagrant/scripts/util.sh

load_proxy

wget -qO- https://packages.microsoft.com/keys/microsoft.asc | apt-key add -

add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/16.04/mssql-server-2017.list)"

apt-get update 
apt-get install -y mssql-server

MSSQL_PID="Developer" ACCEPT_EULA="Y" MSSQL_SA_PASSWORD="v@grantDB" /opt/mssql/bin/mssql-conf -n setup

add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/16.04/prod.list)"

apt-get update 
ACCEPT_EULA="Y" apt-get install -y mssql-tools unixodbc-dev

/opt/mssql-tools/bin/sqlcmd -U SA -P 'v@grantDB' -Q "create database vagrant"