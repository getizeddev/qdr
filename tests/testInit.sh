#!/usr/bin/env bash

#DEBUGGING ONLY: CHECK TABLE IS EMPY --- {{{
# Checking if the file is empty
lenTable=$(wc -l ~/.test_table | awk '{print $1}')
printf "DEBUG: lenTable=%s\n" $lenTable
if [ "$lenTable" -eq  "0" ]; then
    printf "No saved keys found. The list is empty\n"
fi
#--}}}

# loading the table as associative array
declare -A table

while IFS=';' read -r ky val; do
    table[$ky]="$val"
done < ~/.test_table

printf "DEBUG:\nTABLE VALUES:\n"
printf "%s\n" ${table[@]}
printf "####\n"

# Main logic
if [[ $1 == "-i" ]]; then
    localPath=$(pwd)
    key=$2
    if [[ ${#key} -gt 8 ]]; then
        printf "Keys can have a maximum of 8 characters\n"
        exit 1
    fi

    if [[ -n ${table[$key]} ]]; then
        printf "The entered key \x1b[1m$key\x1b[0m has already been used\n"
        exit 1
    else
        printf "DEBUG: \x1b[1m$key\x1b[0m free: not been used yet\n"
    fi
    echo "${key};${localPath}" >> ~/.test_table
    printf "Portal \x1b[1m${key}\x1b[0m created\n"
else
    echo "invalid option $1"
    exit 1
fi 
