#!/bin/bash

: '
Author : Khaled Gad
Date : 4/2/2023 01:00 PM
Description : Create new table and information about columns and its datatypes

Test Cases:
1- enter invalid table name [Done]
2- enter existing table name [Done]
3- enter alpha in columns number [Done]
4- enter invaild column data type [Done]
5- enter invalid column name
6- enter invalid data and make sure that table file created if all input is valid [Done]
'

shopt -s extglob
export LC_COLLATE=C

# This vars needed when test file without table-menu
#dbName="test"  
#dbLocation="../../Databases/$dbName"

tableName=""
tableMetaFile=""

getTableinfo(){
    columnsNo=""
    columnDataType=""
    echo -e "\nEnter the number of column in $tableName"
    read -p "---> " columnsNo
    if [[ $columnsNo =~ ^[0-9]*$ && ( $columnsNo -gt 0 && $columnsNo -le 10 ) ]]
    then
        typeset -i i=1
        while [ $i -le $columnsNo ]; do
            echo -e "\nEnter column $i Name"
            read -p "---> " columnName
            if [[ $columnName =~  ^[_A-Za-z]([_A-Za-z0-9]{1,20})$ ]]
            then
                echo -e "\nEnter the data type of the [$columnName] column"
                PS3="---> "
                select choice in "string" "number"
                do
                    case $REPLY in
                        1)  columnDataType="string"; break;;
                        2)  columnDataType="number"; break;;
                        *) echo "Wrong choice, it must be 1 or 2" ;;
                    esac
                done
            else
                echo -e "\nError: Column names must contain only A to Z, 0 to 9, and underscore (_) characters and not start with numbers."
                sleep 2
                continue
            fi
            # save meta data of each column in the following order
            # Name : datatype
            meta[$i]="$columnName:$columnDataType"
            i=$i+1
        done
        touch $dbLocation/$tableName
        touch $dbLocation/$tableMetaFile
        i=1
        while [ $i -le ${#meta[@]} ]
        do
            echo ${meta[$i]} >> "$dbLocation/$tableMetaFile"
            let i=$i+1
        done
        echo -e "\n{$tableName} table created successfully inside {$dbName} database\n"
        sleep 3
    else
        echo -e "\nError: the number of columns must be in range(1, 10)"
        sleep 2
        getTableinfo
    fi
}

createNewTable(){
    echo -e "\nName of the new table\nMust start with _ or alphabets and contain no sapces or special characters"
    read -p "---> " tableName

    # Check the name of the table is vaild
    if [[ $tableName =~ ^[_A-Za-z]([_A-Za-z0-9]{2,31})$ ]]
    then
        # Check the existing of the table in Database
        if [[ -f "$dbLocation/$tableName" ]]
        then
            echo -e "\nThe {$tableName} table is already exists"
            sleep 3
        else
            tableMetaFile=".meta-$tableName"
            getTableinfo
        fi
    else
        echo -e "Error: the table name must contain only a to z, A to Z, 0 to 9, and underscore (_) characters and not start with numbers. \n"
        sleep 2
        createNewTable
    fi
}
#createNewTable