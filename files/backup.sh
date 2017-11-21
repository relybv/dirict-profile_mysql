#!/bin/bash
echo "Starting backup job" > /root/bku.log
bkupath="/var/lib/mysql/"
now=$(date "+%d-%m-%Y")
bkufile="${bkupath}all_databases-${now}-.sql"
/usr/bin/mysqldump --all-databases > $bkufile
/usr/bin/pigz --best $bkufile
echo "End backup for ${now}" >> /root/bku.log
