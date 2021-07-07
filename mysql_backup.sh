#!/bin/bash
DUMP=/usr/bin/mysqldump
OUT_DIR=/mnt/mysqlback/
DB_USER="root"
DB_PASS="Zc123456@521"
DB_HOST="localhost"
DB_NAME="dmeo"

#How much days backup most
DAYS=1

#Core of script
cd $OUT_DIR
DATE=`date +%Y_%m_%d`
OUT_SQL="$DATE.sql"
TAR_SQL="mysql_$DATE.tar.gz"
#$DUMP --default-character-set=utf8 --opt -u$DB_USER -p$DB_PASS $DB_NAME > $OUT_SQL
$DUMP --default-character-set=utf8 --opt -u$DB_USER -p$DB_PASS -h$DB_HOST $DB_NAME > $OUT_SQL


tar -czf $TAR_SQL ./$OUT_SQL
rm $OUT_SQL
find ./ -name "mysql*" -type f -mtime +$DAYS -exec rm {} \;