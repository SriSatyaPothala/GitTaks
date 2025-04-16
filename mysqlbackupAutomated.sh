#!/bin/bash


#Declare all variables used to connect to database

DB_HOST="localhost"
DB_NAME="mydatabase"
BACKUP_DIR="/home/ec2-user/backupdir"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

#To ensure backup directory is present
mkdir -p /home/ec2-user/backupdir

echo "Backuping database $DB_NAME......"

#To connect to database and take backup (logical/All sql statements used to recreate the database) 
mysqldump -h $DB_HOST $DB_NAME > "$BACKUP_DIR/DB_BACK_UP_$TIMESTAMP.sql"

#compress the backedup file
gzip "$BACKUP_DIR/DB_BACK_UP_$TIMESTAMP.sql"

#you can unzip this file and restore the database using following commands
#gunzip -k ".....sql.gz" and mysql -u "username' dbname < "/path/to/unzipped .sql file"

#Remove the oldbackups (older than 7 days)
#find $BACKUP_DIR -type f -name "*.gz" -mtime +7 -exec rm -f {} \;

echo "Backup completed Successfully"

function clean_old_backups(){
	ls -t "$BACKUP_DIR"/DB_BACK_UP_*.sql.gz | tail -n +8 | xargs rm -f


	echo "Old backups deleted Successfully. Only the most recent 7 are kept. "
}
clean_old_backups
