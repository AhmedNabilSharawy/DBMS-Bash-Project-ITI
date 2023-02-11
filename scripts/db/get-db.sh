#!/bin/bash

: '
Author : Khaled Gad
Date : 11/2/2023 14:00 PM
Description : get database from a menu and validate the choice
'

getDB(){
    local dbs=($(ls ./Databases))
    local dbsLength=${#dbs[*]}
    local msg="\nDatabases is empty\n"
    local title=$1
    [ $dbsLength -eq 0 ] && echo -e $msg && return 2
    
    while [ true ]; do
        customMenu "$title" 0 ${dbs[*]} "Back to Main-Menu" "Exit"
        # store the returned value form customMenu function which contain database
        local db=$?
        if [[ $db -gt 0 && $db -le $dbsLength ]]
        then
            dbName="${dbs[$(($db-1))]}"
            break
        elif [ $db -eq $(($dbsLength+1)) ]
        then
            return 2
        elif [ $db -eq $(($dbsLength+2)) ]
        then
            exit 0
        else
            echo -e "\nError: The value must be between (1, $(($dbsLength+2)))\n"
        fi
    done
}