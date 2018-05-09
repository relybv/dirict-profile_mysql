#!/bin/bash
echo "Starting backup job" > /root/bku.log
#bkupath="/var/lib/mysql-local/"
bkupath="/backup"
now=$(date "+%d-%m-%Y")
bkufile="${bkupath}all_databases-${now}-.sql"
/usr/bin/mysqldump --all-databases > $bkufile
/usr/bin/pigz --best $bkufile
find /backup/all_databases* -mtime +1 -type f -delete
echo "End backup for ${now}" >> /root/bku.log
