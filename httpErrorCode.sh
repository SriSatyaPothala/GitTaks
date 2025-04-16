#!/bin/bash

#define the http URL
URL="www.guvi.in"

#fetch the error code
HTTP_CODE=$(curl -o /dev/null  -s -L -w"%{http_code}" $URL 2>&1)

if [[ $HTTP_CODE =~ ^[0-9]+$ ]]; then
	echo "Received HTTP CODE: $HTTP_CODE"
	
	if [[ $HTTP_CODE -ge 200 && $HTTP_CODE -lt 300 ]]; then 
		echo "HTTP CODE MESSAGE: SUCCESS"
	elif [[ $HTTP_CODE -ge 400 && $HTTP_CODE -lt 500 ]]; then
		echo "HTTP CODE MESSAGE: CLIENT SIDE ERROR"
	elif [[ $HTTP_CODE -ge 500 && $HTTP_CODE -lt 600 ]]; then
		echo "HTTP CODE MESSAGE: SERVER SIDE ERROR"
	else
		echo "Unexpected Status code"
	fi
else
	echo "Curl Error: $HTTP_CODE"
fi

#httpErrorCodeOP.png has the output
#textSubstitutionScript.sh is the second task script
