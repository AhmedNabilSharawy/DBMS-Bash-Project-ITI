#!/bin/bash

: '
Author : Khaled Gad
Date : 4/2/2023 03:45 PM
Description : Remove table from the database with all its data 

Test Cases:
1- enter invalid table name [Done]
2- enter not existing table name [Done]
'

shopt -s extglob
export LC_COLLATE=C

# This vars needed when test file without table-menu
#dbName="test"  
#dbLocation="../../Databases/$dbName"

tableName=""

dropTable(){
    echo -e "\nName of the table you want to drop"
    read -p "---> " tableName

    # Check the name of the table is vaild
    if [[ $tableName =~ ^[_A-Za-z]([_A-Za-z0-9]{2,31})$ ]]
    then
        # Check the existing of the table in Database
        if [[ -f "$dbLocation/$tableName" ]]
        then
            rm $dbLocation/$tableName
            rm $dbLocation/.meta-$tableName
            echo -e "\nThe {$tableName} table has been deleted successfully"
            sleep 3
        else
            echo -e "\nThe given table is not exist in {$dbName} database"
            sleep 2
            dropTable
        fi
    else
        echo -e "\nError: Invalid table name."
        sleep 2
        dropTable
    fi
}
# dropTable