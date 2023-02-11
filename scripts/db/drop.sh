#!/bin/bash
: '
Author : Ahmed Nabil
Date : 04-02-2023
Description: Drop Database based on user input

Test Cases covered:
1- Check user input of Database is existed.
2- Empty input is handeled.
3- User input within Range of select.
'
shopt -s extglob
export LC_COLLATE=C

#check Database Entered exists
dropDB(){
    # local dbs=($(ls ./Databases))
    # local dbsLength=${#dbs[*]}
    # local msg="\nDatabases is empty\n"
    # local dbName=""
    # [ $dbsLength -eq 0 ] && echo -e $msg && return
    
    # while [ true ]; do
    #     customMenu "Choose Database that you want to drop" 0 ${dbs[*]} "Back to Main-Menu" "Exit"
    #     # store the returned value form customMenu function which contain database
    #     local db=$?
    #     if [[ $db -gt 0 && $db -le $dbsLength ]]
    #     then
    #         dbName="${dbs[$(($db-1))]}"
    #         break
    #     elif [ $db -eq $(($dbsLength+1)) ]
    #     then
    #         return
    #     elif [ $db -eq $(($dbsLength+2)) ]
    #     then
    #         exit 0
    #     else
    #         echo -e "\nError: The value must be between (1, $(($dbsLength+2)))\n"
    #     fi
    # done
    local dbName=""
    getDB "Choose Database that you want to drop"
    
    # exit from function if getDB returned 2
    [ $? -eq 2 ] && return

    if [[ -d ./Databases/$dbName ]]; then
        rm -r ./Databases/$dbName 
        msg="Database $dbName removed successfully"
    else
        msg="Database Doesn't Exist"
    fi
    echo -e "\n$msg\n"
}
#dropDB
