#!/usr/bin/env bash

case $1 in
    -i | --init ) 
        if ! [[ -n "$2" ]]; then
            printf "\x1b[1;31m--init (-i)\x1b[0m option requires an argument\n"
        else
            echo $2
        fi;;
    -r | --remove ) echo $2;;
    -l | --list ) echo "list";;
    -h | --help ) echo "help";;
    -* ) printf "\x1b[1mqdr\x1b[0m: invalid option $1\nTry \x1b[90m'qdr -h'\x1b[0m or \x1b[90m'qdr --help'\x1b[0m for more information";;
    * ) echo "no option";;
esac 
