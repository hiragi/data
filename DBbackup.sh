#!/bin/zsh

echo MySQL Database Export
echo Saving database $1@$MY_DB_NAME to $MY_HOME/data/ExpDat.dmp

if [ $# -eq 0 ] 
  then
    echo "Usage:    $0 <userAccount> <userPassword>" 
    echo "Example:    $0 myaccount mypass" 
    exit 1
fi
if [ "$MY_HOME" = "" -o  "$MY_DB_NAME" = "" -o "$MY_DB_SERVER" = "" -o "$MY_DB_PORT" = "" ]
then
    echo "Please make sure that the environment variables are set correctly:" 
    echo "    MY_HOME         e.g. /myhome" 
    echo "    MY_DB_NAME   e.g. mydbname" 
    echo "      MY_DB_SERVER e.g. dbserver.mydomain.com or 192.168.0.1" 
    echo "      MY_DB_PORT   e.g. 5432 or 1521" 
    exit 1
fi
mysqldump -h $MY_DB_SERVER -P $MY_DB_PORT -u $1 --password=$2 --single-transaction --routines --no-create-db $MY_DB_NAME > $MY_HOME/data/ExpDat.dmp

cd $MY_HOME/data
# jar cvfM ExpDat.jar ExpDat.dmp
tar zcvf ExpDat.tgz ExpDat.dmp
