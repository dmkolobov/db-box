#!/bin/bash 

source /vagrant/scripts/util.sh

load_rc

wget -qO- https://packages.microsoft.com/keys/microsoft.asc | apt-key add -

add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/16.04/mssql-server-2017.list)"

apt-get update 
apt-get install -y mssql-server

MSSQL_PID="Developer" ACCEPT_EULA="Y" MSSQL_SA_PASSWORD=$DB_PASS /opt/mssql/bin/mssql-conf -n setup

add-apt-repository "$(wget -qO- https://packages.microsoft.com/config/ubuntu/16.04/prod.list)"

apt-get update 
ACCEPT_EULA="Y" apt-get install -y mssql-tools unixodbc-dev

/opt/mssql-tools/bin/sqlcmd -U SA -P "$DB_PASS" -Q "create login $DB_USER with password = '$DB_PASS'"
/opt/mssql-tools/bin/sqlcmd -U SA -P "$DB_PASS" -Q "exec sp_addsrvrolemember @loginame = N'$DB_USER', @rolename = 'sysadmin'"
/opt/mssql-tools/bin/sqlcmd -U SA -P "$DB_PASS" -Q "create database $DB_SCHEMA"

systemctl stop mssql-server 
systemctl start mssql-server