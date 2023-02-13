#!/bin/bash

: '
Author : Khaled Gad
Date : 8/2/2023 8:40 PM
Description : Insert data to specific table in database
'

#source ./select.sh

shopt -s extglob
export LC_COLLATE=C

insertData(){
    local tableName=""
    printf "\n"
    getTable "Select Table that you want to insert data in"
    [ $? -eq 2 ] && return

    local tableColumns=($(cut -f1 -d: $dbLocation/.meta-$tableName))
    local columnsDatatype=($(cut -f2 -d: $dbLocation/.meta-$tableName))

    # get id of the row
    local lastID=0
    local ID=0
    [ -s $dbLocation/$tableName ] &&  lastID=$(tail -1 $dbLocation/$tableName | cut -f1 -d:)
    let ID=$lastID+1
    local row="$ID"

    typeset -i column=0
    while [ $column -lt ${#tableColumns[@]} ]
    do
        echo -e "\nEnter data of column $((($column+1)))"
        read -p "${tableColumns[$column]} = " value
        case ${columnsDatatype[$column]} in
            "string")
                if ! [[ $value =~ [a-zA-Z]+ ]]
                then 
                    echo -e "\nInvalidValue : the value can not be only numbers"
                    continue
                fi
                ;;
            "number")
                if ! [[ $value =~ ^[0-9]+$ ]]
                then
                    echo -e "\nValueError: The value must be only numbers"
                    continue 
                fi
                ;;
        esac
        row+=":$value"
        column=$column+1
    done
    echo $row >> $dbLocation/$tableName
    echo -e "\nThe row was inserted successfully with ID = $ID\n"
}
#insertData