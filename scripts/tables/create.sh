#!/bin/bash

: '
Author : Khaled Gad
Date : 4/2/2023 01:00 PM
Description : Create new table and information about columns and its datatypes

Test Cases:
1- enter invalid table name [Done]
2- enter existing table name [Done]
3- enter calpha in olumns number [Done]
4- enter invaild column data type [Done]
5- enter invalid column name
6- enter invalid data and make sure that table file created if all input is valid [Done]
'

shopt -s extglob
export LC_COLLATE=C

getTableinfo(){
    local columnsNo=""
    local columnDataType=""
    # echo -e "\nEnter the number of column in $tableName"
    printf "\n"
    read -p "Enter the number of column in $tableName [1-10] : " columnsNo
    # ---------------------> change * in regex  <---------------------
    if [[ $columnsNo =~ ^([1-9]|10)$ ]]
    then
        local i=1
        for(( ; i <= $columnsNo; i++)); do
            printf "\n"
            read -p "Enter column $i Name : " columnName
            printf "\n"
            if [[ $columnName =~  ^[_A-Za-z]([_A-Za-z0-9]{1,20})$ ]]
            then
                while true; do
                    customMenu "DataType of $columnName column" 0 "string" "number"
                    choice=$?
                    case $choice in
                        1)  columnDataType="string"; break;;
                        2)  columnDataType="number"; break;;
                        *) echo -e "\nWrong choice, it must be 1 or 2\n" ;;
                    esac
                done
            else
                echo -e "\nError: Column names must contain only A to Z, 0 to 9, and underscore (_) characters and not start with numbers.\n"
                continue
            fi
            # save meta data of each column in array at the following format
            # Name : datatype
            meta[$i]="$columnName:$columnDataType"
        done
        # create the table file and meta file or it
        touch $dbLocation/$tableName
        touch $dbLocation/$tableMetaFile

        # putting the informations about columns in meta file
        i=1
        while [ $i -le ${#meta[@]} ]
        do
            echo ${meta[$i]} >> "$dbLocation/$tableMetaFile"
            let i=$i+1
        done
        echo -e "\n$tableName table created successfully inside {$dbName} database"
    else
        echo -e "\nError: the number of columns must be in range(1, 10)"
        getTableinfo
    fi
}

createNewTable(){
    local tableName=""
    local tableMetaFile=""

    # echo -e "\nMust start with _ or alphabets and contain no sapces or special characters"
    printf "\n"
    read -p "Name of the new table : " tableName

    # Check the name of the table is vaild
    if [[ $tableName =~ ^[_A-Za-z]([_A-Za-z0-9]{2,31})$ ]]
    then
        # Check the existing of the table in Database
        if [[ -f "$dbLocation/$tableName" ]]
        then
            echo -e "\nThe $tableName table is already exists"
            createNewTable
        else
            tableMetaFile=".meta-$tableName"
            getTableinfo
        fi
    else
        echo -e "\nValue Error: the table name must contain only a to z, A to Z, 0 to 9, and underscore (_) characters and not start with numbers. \n"
        createNewTable
    fi
}
#createNewTable