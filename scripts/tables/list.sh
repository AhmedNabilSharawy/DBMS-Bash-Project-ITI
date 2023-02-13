#!/bin/bash

: '
Author : Khaled Gad
Date : 4/2/2023 05:25 PM
Description : List all tables in the database 
'

listTables(){
    local tables=($(ls $dbLocation))
    printf "\n"
    [ ${#tables} -eq 0 ] && echo "$dbName database is empty" && return 
    customMenu "All Tables in $dbName Database" 1 "${tables[@]}"
}
# listTables