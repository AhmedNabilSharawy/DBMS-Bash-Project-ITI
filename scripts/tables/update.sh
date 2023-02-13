#!/bin/bash

: '
Author : Ahmed Nabil
Date : 11-02-2023
Description : Update data from table 
'


shopt -s extglob
export LC_COLLATE=C

updateFromTable(){

    # ask user which table to update from

    local tableName=""
    printf "\n"
    getTable "Select table that you want to Update in: "
    [ $? -eq 2 ] && return # return if database empty or 

    # get condition used to update from user
    # tail used to eliminate pk from update menu 
    updatedColumn=($(cut -f1 -d: $dbLocation/.meta-$tableName))
    updatedLength=${#updatedColumn[@]}

    # choose updated column from user
    while true; do
        PS3="Enter Column you want to update in Please:"
        select choice in ${updatedColumn[@]}
        do
            if [[ $REPLY -ge 1 && $REPLY -le $updatedLength ]];then
                # get selected column datatype
                updatedColNum=$(($REPLY+1))
                dataType=$(awk -F: -v colName=$choice '{if ($1==colName) print $2}' $dbLocation/.meta-$tableName)
                break 2
            else
                
                echo "Invalid Number, please enter number from 1 to $(($updatedLength+1)):"
            fi
            break
        done
    done

    # take updated value from user and validate it matches datatype
    while true; do

        read -p "Enter new value in $choice: " newValue
        echo #formating new line
        if [[ $dataType == string ]];then
            if [[ $newValue =~ [a-zA-Z]+$ ]]; then
                
                echo -e "\nYour answer saved Successfully "
                break
            else
                echo -e "\nPlease enter value matching datatype"
                continue
            fi
        else # else here refer to number datatype
            if [[ $newValue =~ ^[0-9]+$ ]]; then
                echo -e "\nYour answer saved Successfully "
                break
            else
                echo -e "\nPlease enter value matching datatype"
                continue
            fi
        fi
    done

    # filter by column based on user choice
    while true; do
        echo -e "Enter Column you want to filter by please \n"
        select choice in "_id" ${updatedColumn[@]}
        do
            if [[ $REPLY -ge 1 && $REPLY -le $(($updatedLength+1)) ]]
                then
                    columnNum=$REPLY
                    columnName=$choice
                    echo -e "Your answer saved Successfully \n"
                    break 2
                else
                    echo -e "Invalid Number, please enter number from 1 to $updatedLength: \n"
                fi
            break
        done
    done

    # take input from user to select row by it based on filtered column
        read -p "Enter value in $columnName to select row by it: " selectValue
    # update statement
    updateNumber=$(awk -F: -v updateColNum=$updatedColNum -v newVal=$newValue -v filtrColNum=$columnNum -v selectVal=$selectValue 'BEGIN{OFS=":";} {if ($filtrColNum==selectVal) print $0}' $dbLocation/$tableName | wc -l )
    update=$(awk -F: -v updateColNum=$updatedColNum -v newVal=$newValue -v filtrColNum=$columnNum -v selectVal=$selectValue 'BEGIN{OFS=":";} {if ($filtrColNum==selectVal) {$updateColNum=newVal} print $0}' $dbLocation/$tableName > tmpfile && mv tmpfile $dbLocation/$tableName)

    if [[ $updateNumber -gt 0 ]]; then
        echo -e "\n$updateNumber Record Updated Successfully"
    else
        echo -e "\nNo Records Matched"

    fi
}