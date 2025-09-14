#!/usr/bin/env bash

qdr() {

    function helpDoc() {
    # display help doc in pager {{{
        printf "\x1b[1mNAME
        qdr\x1b[0m - quick directory
        
    \x1b[1mSYNOPSIS
        \x1b[1mqdr\x1b[0m \x1b[4mkey
        \x1b[1mqdr \x1b[0m[-i | --init] [-r | --remove] \x1b[4mkey
        \x1b[1mqdr \x1b[0m[-l | --list] [-h | --help] 
              
    \x1b[1mDESCRIPTION
        The \x1b[1mqdr\x1b[0m script facilitates the navigation to specific directories 
        via use of user-defined \x1b[4mkeys\x1b[0m.
        The keys and the paths are stored in a text file ('.qdr_table')
        located in the home directory (~).
        If passed without options but only with a key, \x1b[1mqdr\x1b[0m will cd the user
        to the location associated with the key.
        Keys can be deleted and must have a length of max. 8 characters.
        
        The options are as follows:
        
        \x1b[1m-i, --init\x1b[0m \x1b[4mkey
                    Add the working directory of the current shell execution
                    environment to the saved paths, passing a desired key as 
                    argument.
        
        \x1b[1m-r, --remove\x1b[0m \x1b[4mkey
                    Remove the key passed as argument (and the relative
                    path) from the table.
                    
        \x1b[1m-l,  --list\x1b[0m
                    Print the list of keys-paths mappings currently saved.
                    
        \x1b[1m-h,  --help\x1b[0m
                    Open the help document in a pager.
                    

    \x1b[1mEXIT STATUS
        The qdr script exits 0 on success, and >0 if an error occurs.

    \x1b[1mEXAMPLES
        Given we are in '~/Desktop/<...>/mydirectory/', we can create a
        key that would bring us to this directory from any other location
        in our system
            
            qdr -i myd
            
        Now, given we are in any other location on out system, we can
        navigate directly to '.../mydirectory/
        
            qdr myd
            
        We can remove this key and its value from our table by:
            
            qdr -r myd\n" | less -R  
    # }}}
    }

    function init() {
    # save directory path and assign key {{{

        local localPath=$(pwd)
        local key=$1

        if [[ ${#key} -gt 8 ]]; then
            printf "Keys can be max 8 characters long\n"
            return 1
        fi

        # We check if the enterd key has already been used.
        if [[ -n ${table[$key]} ]]; then
            printf "Key \x1b[1m${key}\x1b[0m has already been used. Please use a new key\n"
            return 1
        fi
        
        #add the key and the current path to the table.
        echo "${key};${localPath}" >> ~/.qdr_table
        printf "Key \x1b[1m${key}\x1b[0m created\n"

        return 0
    # }}}
    }

    function remove() {
        # remove key (and path) from saved list  {{{
        local key=$1

        # Check if the table is empty 
        if [[ $lenTable -eq  0 ]]; then
            printf "Currently there are no keys saved. Nothing to delete here."
            return 1
        fi
        
        # check if the key passed is in the table
        if [[ ! -n ${table[$key]} ]]; then
            printf "\x1b[1m${key}\x1b[0m not found!\n"
            return 1
        fi

        # delete the key and rewrite the table file.
        unset "table[$key]"
        printf "\x1b[1m${key}\x1b[0m removed successfully\n"
        for elem in ${!table[@]}; do
            printf "%s;%s\n" $elem "${table[$elem]}"
        done > ~/.qdr_table

        return 0
    # }}}
    }

    function tableList() {
    # print table of all saved key/path  ----{{{
        # Check if the table is empty
        if [[ $lenTable -eq  0 ]]; then
            printf "Currently there are no saved keys.\n"
            return 1
        fi

        # Print table
        printf "\x1b[1;41m %-9s| %-48s\x1b[0m\n" "Key" "Path"
        for elem in ${!table[@]}; do
            printf " %-9s| %-48s\n" $elem "${table[$elem]}"
        done

        return 0
    # ---}}}
    }

    function relocate() {
    # relocate to desired path - arg: key {{{
        local key=$1

        if [[ -n ${table[$key]} ]]; then
            cd ${table[$key]}
            return $?
        fi

    # }}}
    }

    # Starting the main logic
    local -A table

    # read length if file exists. if not, length =  0
    if [[ -e ~/.qdr_table ]]; then
        lenTable=$(wc -l ~/.qdr_table | awk '{print $1}')
    else
        lenTable=0
    fi

    # if file is not empty, populate the array table
    if [[ "$lenTable" -ne "0" ]]; then
        while IFS=';' read -r ky val; do
            table[$ky]="$val"
        done < ~/.qdr_table
    fi

    # Reading options
    case $1 in
        -i | --init ) 
            if ! [[ -n "$2" ]]; then
                printf "\x1b[1;31m--init (-i)\x1b[0m option requires an argument\n"
            else
                init $2
            fi;;

        -r | --remove ) 
            if ! [[ -n "$2" ]]; then
                printf "\x1b[1;31m--remove (-r)\x1b[0m option requires an argument\n"
            else
                remove $2
            fi;;

        -l | --list ) tableList;;

        -h | --help ) helpDoc;;

        -* ) printf "\x1b[1mqdr\x1b[0m: invalid option $1\nTry \x1b[90m'qdr -h'\x1b[0m or \x1b[90m'qdr --help'\x1b[0m for more information";;

        * ) relocate $1;;
    esac

    # Unset all internal functions
    unset -f init
    unset -f remove
    unset -f relocate
    unset -f tableList
    unset -f helpDoc

    return 0
}
