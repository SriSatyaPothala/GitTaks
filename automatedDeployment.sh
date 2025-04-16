#!/bin/bash
servers=("server1","server2","server3")
for server in "${servers[@]}"; do
    rsync -avz "app.tar.gz" "user@$server:/path/to/dest"  
    ssh "user@$server" "tar -xvzf /path/to/dest/app.tar.gz -C /path/to/app"
    #can add additional deployment steps here 
done