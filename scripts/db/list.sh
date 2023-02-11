#!/bin/bash
: '
Author : Ahmed Nabil
Date : 04-02-2023
Description: Display Database based on user input

Test Cases covered:
1- Check Database is empty or not.
'

shopt -s extglob
export LC_COLLATE=C

listDB(){
    local dbs=($(ls ./Databases))
    local dbsLength=${#dbs[*]}
    local msg="\nDatabases is empty\n"
    [ $dbsLength -eq 0 ] && echo -e $msg && return
    customMenu "List of Databases     " 1 ${dbs[*]}
}
#listDB

#     # -n $DbName checks that input is not empty 
#     if [[ "$(ls ./Databases)" ]]; then
    
#         clear #formating

#         ls ./Databases
#         echo #formating new line

#         #Display menu to user
#         askMenuWithoutCont
#     else
#         clear #formating 
#         echo "Database is empty"
#         echo #formating new line
#         #Display menu to user
#         askMenuWithoutCont
#     fi
# done
