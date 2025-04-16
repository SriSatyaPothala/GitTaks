#!/bin/bash

PROCESS="nginx"
PIDS=$(pgrep "$PROCESS")
MAX_MEM=5
TOTAL_MEM=$(grep MemTotal /proc/meminfo | awk '{print $2}')
ALL_PID_mem_usage=0 

if [[ -n "$PIDS" ]]; then
    for pid in $PIDS; do
        memory_usage=$(ps -p "$pid" -o rss= | awk '{print $1}')
        #calculate the entire memory used by the process with different PIDs
        ALL_PID_mem_usage=$(( ALL_PID_mem_usage + memory_usage ))
    done
    #calculate the memory usage in percentage
    memory_usage_percentage=$(( (ALL_PID_mem_usage * 100) / TOTAL_MEM ))

    if [[ "$memory_usage_percentage" -gt "$MAX_MEM" ]]; then
        kill -9 $PIDS
        echo "Process is killed due to high memory usage of "$memory_usage_percentage""
    else
        echo "Process is running within limits"
    fi
else
    echo "process "$PROCESS" is not running"
fi 
