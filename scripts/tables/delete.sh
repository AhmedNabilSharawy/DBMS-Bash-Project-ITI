#!/bin/bash

: '
Author : Ahmed Nabil
Date : 08-02-2023
Description : Delete data from table 
'

shopt -s extglob
export LC_COLLATE=C

deleteFromTable(){
    # ask user which table to delete from

    local tableName=""
    printf "\n"
    getTable "Select table that you want to Update in: "
    [ $? -eq 2 ] && return # return if database empty or 
    
        # get condition used to delete from user
    deletedColumn=($(cut -f1 -d: $dbLocation/.meta-$tableName))
    deletedLength=${#deletedColumn[@]}
 
    while true; do
        clear # formating
        echo "Select Column you want to delete by Please"
        echo #formating new line
        select choice in "_id" ${deletedColumn[@]} "all table data"
        do
            if [[ $REPLY -ge 1 && $REPLY -le $(($deletedLength+1)) ]]
                then
                    columnNum=$REPLY
                    read -p "enter value in $choice you want to delete: " delValue
                    break 2
            elif [[ $REPLY -eq $(($deletedLength+2)) ]]
                then
                    echo "" > $dbLocation/$tableName
                    echo "all table $tableName data deleted Successfully"
                else
                    echo "Invalid Number, please enter number from 1 to $(($deletedLength+2)):"
                    echo #formating new line
                fi
        done
    done

    delLineNumber=$(awk -F: -v val=$delValue -v colNum=$columnNum '$colNum == val' $dbLocation/$tableName | wc -l)
    deleted=$(awk -F: -v val=$delValue -v colNum=$columnNum '$colNum != val' $dbLocation/$tableName > tmpfile && mv tmpfile $dbLocation/$tableName)
    
    # greater than 0 to go to else stmt
    if [[ $delLineNumber -gt 0 ]]; then
        echo "$delLineNumber Record Deleted Successfully"
    else
        echo "No Records Matched"
    fi
}
