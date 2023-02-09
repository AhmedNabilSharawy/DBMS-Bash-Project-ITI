#!/bin/bash

: '
Author : Ahmed Nabil
Date : 08-02-2023
Description : Update data from table 
'
source ./select.sh # shall be removed from here

dbName="test"
dbLocation="../../Databases/$dbName"

shopt -s extglob
export LC_COLLATE=C

updateFromTable(){
    # ask user which table to delete from
    chooseTable

    # get condition used to delete from user
    updatedColumn=($(cut -f1 -d: $dbLocation/.meta-$tableName))
    updatedLength=${#updatedColumn[@]}

    while true; do
        echo "Enter Column you want to update in Please"
        select choice in ${updatedColumn[@]}
        do
            if [[ $REPLY -ge 1 && $REPLY -le $tablesLength ]]
                then
                    # holds column to be updated
                    columnName=$choice 

                    # get selected column datatype
                    dataType=$(awk -F: -v colName=$columnName '{if ($1=="colName") print $2}' $dbLocation/.meta-$tableName)
                    read -p "enter new value in $choice you want to Update: " updatedValue
                    if [[ $updatedValue == string ]]
                        then
                    break 2
            elif [[ $REPLY -eq $(($tablesLength+1)) ]]
                then
                    echo "" > $dbLocation/$tableName
                    clear # formating
                    echo "all table $tableName data deleted Successfully"
                    break 2
                else
                    clear # formating
                    echo -e "\nError: wrong choice\nTry Again\n"
                    sleep 2
                fi
            break
        done
    done

    delLineNumber=$(awk -F: -v val=$delValue -v colNum=$columnNum '$colNum == val' $dbLocation/$tableName | wc -l)
    deleted=$(awk -F: -v val=$delValue -v colNum=$columnNum '$colNum != val' $dbLocation/$tableName > tmpfile && mv tmpfile $dbLocation/$tableName)
    
    # greater than 0 to go to else stmt
    if [[ deleted -gt 0 ]]; then
        clear # formating
        echo "$delLineNumber Record Deleted Successfully"
    else
        clear # formating
        echo "No Records Matched"
    fi
}
updateFromTable