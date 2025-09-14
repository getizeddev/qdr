#!/usr/bin/env bash

# Checking if the file is empty
lenTable=$(wc -l ~/.test_table | awk '{print $1}')
printf "DEBUG: lenTable=%s\n" $lenTable
if [ "$lenTable" -eq  "0" ]; then
    printf "No saved keys found. The list is empty\n"
    exit 1
fi

# loading the table as associative array
declare -A table

while IFS=';' read -r ky val; do
    table[$ky]="$val"
done < ~/.test_table

printf "DEBUG:\nTABLE VALUES\n"
printf "%s\n" ${table[@]}
printf "####\n"

# Main logic
if [[ $1 == "-r" ]]; then
    key=$2
    if [[ -n ${table[$key]} ]]; then
        printf "DEBUG:\n\x1b[1m${key}\x1b[0m key found\n"
    else
        printf "\x1b[1m${key}\x1b[0m not found!\n"
        exit 1
    fi
    unset table[$key]
    printf "\x1b[1m${key}\x1b[0m removed\n"
    for elem in "${!table[@]}"; do
        printf "%s; %s\n" ${elem} "${table[${elem}]}"
    done > ~/.test_table 
else
    echo "invalid option $1"
    exit 1
fi
