#!/bin/bash
#Create variables to store source and destination dir paths

source_dir="/home/ec2-user/dirtoBackup"
dest_dir="/home/ec2-user/backedupdir"
backuplist="$dest_dir/backup_dir.tar.gz"

#find files modified in last 24 hours

BackedUpList=$(find $source_dir -type f -mtime -1)
echo "$BackedUpList"

if [ -z "$BackedUpList" ]; then
	echo "No files or folders modified in the last 24 hours. No backup Created"
	exit 0
fi
#remove the old backup
if [ -f $backuplist ]; then
	rm -f $backuplist
fi

#create archive of newly modified files and folders
echo "$BackedUpList" | tar -czf "$backuplist" --absolute-names -T -


echo "Backup Completed: $backuplist"

