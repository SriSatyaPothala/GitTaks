#!/bin/bash


check_jq_installed
function check_jq_installed(){
    if (! command -v jq &> /dev/null); then
        sudo apt update -y && sudo apt install jq -y
}

#Get GITHUB Credentials as ENV Variables
TOKEN=$token

#Get Repo Owner and Repo name as args
REPO_OWNER=$1   # github sometimes have many organizations 
REPO_NAME=$2

#Github API URL
GITHUB_API="https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/collaborators"

function github_get_api(){
    #fetch the list of collaborators 
    collaborators=$( curl -s  -H "Accept: application/vnd.github+json" \
                     -H ""Authorization: Bearer "$TOKEN" \
                     -H "X-GitHub-Api-Version: 2022-11-28" \
                     "$GITHUB_API" )
    if [[ -z $collaborators ]]; then
        echo "No response from Github. Check your Token"
        exit 1
    else 
        if echo "$collaborators" | grep -q "NOT FOUND"; then 
            echo "Error: Repository:"$REPO_NAME" not found or you do not have permission to access"
        else
            echo "List of Collaborators for $REPO_OWNER/$REPO_NAME: "
            echo  "$collaborators" | jq -r '.[].login'
        fi
    fi
    
}
#helper function
function helper(){
    expected_cmd_args=2
    if [ $# -ne "$expected_cmd_args" ]; then
        echo "Please pass the repo owner and repo name as args respectively"
        exit 1
    fi
}
helper "$@"
github_get_api
