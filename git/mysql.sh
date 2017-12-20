#!/bin/bash
# Script – mysqlbackup2.sh
# Created by Avi NJIT IT610 12062017

DATADIR=”/home/ubuntu/mysqlbackups”
USERNAME=root
PASSWORD=password
NOW=$(date +”%d-%m-%Y_%H-%M”)

#BACKUP DATABASE in date format (eg “MyDatabase-date-month-year-hour-minute-second.sql”)
mysqldump -u $USERNAME $PASSWORD -p --all-databases > /home/ubuntu/mysqlbackups/MySQLDatabase.$NOW.sql

# REMOVE BACKUPS MORE THAN 35 Min OLD – This removes all files in the directory older 7 jobs, since the cron job is set to do it every 5 min
find /home/ubuntu/mysqlbackups/* -mmin +35 -exec rm {} \;

#create a logfile that can be used by nagios to detects error with script
2>&1 > /var/log/mysqldump.log; echo "Exit code: $?" >> /var/log/mysqldump.log
