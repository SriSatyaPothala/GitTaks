#!/bin/bash
accesslog="/var/log/nginx/access.log"
errorlog="/var/log/nginx/error.log"

#print the top 10 IP's which frequently accessed the server
awk '{print $1}' "$accesslog" | sort | uniq -c | sort -nr | head -n 10
#most frequent error types
awk '{print $6}' "$errorlog" | sort | uniq -c | sort -nr | head -n 10
