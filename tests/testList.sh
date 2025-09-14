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

printf "DEBUG:\nTABLE VALUES:\n"
printf "%s\n" ${table[@]}
printf "####\n"

# Main logic
if [[ $1 == "-l" ]]; then
    printf "\x1b[1;37;100m %-9s\u2502 %-48s\x1b[0m\n" "Key" "Location"
    for elem in "${!table[@]}"; do
        printf " %-9s\x1b[1m\u2502\x1b[0m %-48s\n" ${elem} "${table[$elem]}"
    done
else
    echo "invalid option $1"
    exit 1
fi
