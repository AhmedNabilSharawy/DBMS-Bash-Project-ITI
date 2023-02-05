#!/bin/bash

: '
Author : Khaled Gad
Description : Select specific data from table 
'

shopt -s extglob
export LC_COLLATE=C

# This vars needed when test file without table-menu
dbName="test"  
dbLocation="../../Databases/$dbName"

tables=$(ls $dbLocation)
tablesLength=${#tables[@]}
tableName=""
tableMetaFile=""

chooseTable(){
    # while loop to keep printing menu in the case of error happened 
    while true; do
        echo "Select table that you want to get data from"
        PS3="---> "
        select choice in $tables
        do
            if [[ $REPLY -ge 1 && $REPLY -le tablesLength ]]
            then
                tableName=$choice
                break 2
            else
                echo -e "\nError: wrong choice\nTry Again\n"
                sleep 2
            fi
            #clear
            break
        done
    done
}

selectFromTable(){
    # Menu to let user select specific table from list of tables in database
    chooseTable


}
selectFromTable

: '
1- but tables in menu and select table which i want to select data from 
2- 
'