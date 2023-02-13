#!/bin/bash

: '
Author : Khaled Gad
Date : 4/2/2023 03:45 PM
Description : Remove table from the database with all its data 

Test Cases:
1- enter invalid table name [Done]
2- enter not existing table name [Done]
'

dropTable(){
    local tableName=""
    printf "\n"
    getTable "Select Table to drop in $dbName Database"
    [ $? -eq 2 ] && return
    rm $dbLocation/$tableName
    rm $dbLocation/.meta-$tableName
    echo -e "\nThe $tableName table has been deleted successfully."
}
# dropTable