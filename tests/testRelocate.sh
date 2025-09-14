#!/usr/bin/env bash
function relocate() {
    function inside(){
        echo "Function Inside"
    }
    # It need to be source in order to cd to work in the current shell
    # Checking if the file is empty
    local lenTable=$(wc -l ~/.test_table | awk '{print $1}')
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

    local akey=$1

    if [[ -n ${table[$akey]} ]]; then
        printf "${table[$akey]}\n"
        cd ${table[$akey]}
        printf "DEBUG:\n Redirected!\n"
        inside
        unset -f inside
    else
        printf "\x1b[1m$akey\x1b[0m not found\n"
        exit 1
    fi
}
