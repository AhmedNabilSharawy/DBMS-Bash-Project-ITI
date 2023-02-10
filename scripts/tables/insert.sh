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
    echo "Select Table that you want to insert in"
    chooseTable

    tableColumns=($(cut -f1 -d: $dbLocation/.meta-$tableName))
    columnsDatatype=($(cut -f2 -d: $dbLocation/.meta-$tableName))
    [ -s $dbLocation/$tableName ] &&  lastID=$(tail -1 $dbLocation/$tableName | cut -f1 -d:) || lastID=0
    let ID=$lastID+1
    typeset -i column=0
    row="$ID"
    while [ $column -lt ${#tableColumns[@]} ]
    do
        echo -e "\nEnter data of column $((($column+1)))"
        read -p "${tableColumns[$column]} = " value
        case ${columnsDatatype[$column]} in
            "string")
                if ! [[ $value =~ [a-zA-Z]+ ]]
                then 
                    echo -e "\nValueError: the value can not be only numbers"
                    sleep 1
                    continue
                fi
                ;;
            "number")
                if ! [[ $value =~ ^[0-9]+$ ]]
                then
                    echo -e "\nValueError: The value must be only numbers"
                    sleep 1
                    continue 
                fi
                ;;
        esac
        row+=":$value"
        column=$column+1
    done
    echo $row >> $dbLocation/$tableName
    echo -e "\nThe row was inserted successfully with ID = $ID\n"
    read -p "Press any key to continue..."
}
#insertData