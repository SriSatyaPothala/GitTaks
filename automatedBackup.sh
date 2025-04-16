#!/bin/bash
SOURCE_DIR="logs/"
BACKUP_DIR="backup"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
#to make sure backup dir is present
mkdir -p backup
#archive the files and copy them to dest dir
tar -czf  "$BACKUP_DIR/backup_$TIMESTAMP.tar.gz" "$SOURCE_DIR"

#crontab -e
#0 2 * * * automatedBackup.sh ----> to run it daily 2 AM
