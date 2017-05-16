#!/bin/bash
#Get the name of database
EasyMinerDbName=`mysql --host=easyminer-mysql --user=root --password=root  --execute='show databases like "%000" ' | head -4 | tail -1 | tr -d "|"`
# Delete all rows in users table using mariadb-client runned via docker
mysql --host=easyminer-mysql --user=root --password=root --database=`echo $EasyMinerDbName` --execute='delete from users'