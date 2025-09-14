#!/usr/bin/env bash

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

