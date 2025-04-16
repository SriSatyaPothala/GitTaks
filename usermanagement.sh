#!/bin/bash

#get the username to add|modify|delete using args
username=$1
action=$2
case "$action" in
    "add")
        useradd "$username"
        ;;
    "modify")
        usermod -s /bin/bash "$username"
        ;;
    "delete")
        userdel "$username"
        ;;
    *)
        echo "Usage: $0 {add|Modify|delete} username"
        exit 1
        ;;
    esac

