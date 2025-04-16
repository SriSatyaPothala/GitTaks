#!/bin/bash
sudo apt update -y
sudo apt install mailutils -y
CPU_THRESHOLD=1024
MEMORY_THRESHOLD=1024 #1MB
RECPT_MAILID="satyasreepothala114@gmail.com"
SUBJECT="SYSTEM RESOURCES USAGE ALERT"

CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | sed  -E "s/.*, *([0-9]+\.[0-9]+)%?id.*/\1/" | awk '{print 100 - $1}')
MEMORY_USAGE=$(free | awk '/Mem:/ {print $3/$2 * 100.0}')
if (( $(echo "$CPU_USAGE > $CPU_THRESHOLD" | bc -l ) )) || (( $(echo "$MEMORY_USAGE > $MEMORY_THRESHOLD" | bc -l ) )); then
    echo -e "High CPU or Memory Usage Detected! CPU_USAGE: $CPU_USAGE%\nMEMORY_USAGE: $MEMORY_USAGE%" | mail -s "$SUBJECT" "$RECPT_MAILID"
fi