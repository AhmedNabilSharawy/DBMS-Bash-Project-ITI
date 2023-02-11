#!/bin/bash

: '
Author : Ahmed Nabil
Date : 11-02-2023
Description : Update data from table 
'
#source ./select.sh # shall be removed from here

dbName="test"
dbLocation="../../Databases/$dbName"

shopt -s extglob
export LC_COLLATE=C

updateFromTable(){

    # ask user which table to update from
    chooseTable

    # get condition used to update from user
    # tail used to eliminate pk from update menu 
    updatedColumn=($(cut -f1 -d: $dbLocation/.meta-$tableName | tail +2))
    updatedLength=${#updatedColumn[@]}

    # choose updated column from user
    while true; do
        clear # formating
        echo "Enter Column you want to update in Please"
        select choice in ${updatedColumn[@]}
        do
            if [[ $REPLY -ge 1 && $REPLY -le $updatedLength ]];then
                # get selected column datatype
                updatedColNum=$(($REPLY+1))
                dataType=$(awk -F: -v colName=$choice '{if ($1==colName) print $2}' $dbLocation/.meta-$tableName)
                break 2
            else
                clear # formating
                echo -e "\nError: wrong choice\nTry Again\n"
                sleep 2
            fi
            break
        done
    done

    # take updated value from user and validate it matches datatype
    while true; do
        clear # formating
        read -p "Enter new value in $choice: " newValue
        if [[ $dataType == string ]];then
            if [[ $newValue =~ [a-zA-Z]+ ]]; then
                clear # formating
                echo "Your answer saved Successfully "
                break 2
            else
                clear # formating
                echo "Please enter value matching datatype"
                continue
            fi
        else # else here refer to number datatype
            if [[ $newValue =~ ^[0-9]+$ ]]; then
                clear # formating
                echo "Your answer saved Successfully "
                break 2
            else
                clear # formating
                echo "Please enter value matching datatype"
                continue
            fi
        fi
    done

    # filter by column based on user choice
    while true; do
        clear # formating
        echo -e "Enter Column you want to filter by Please \n"
        select choice in ${updatedColumn[@]}
        do
            if [[ $REPLY -ge 1 && $REPLY -le $updatedLength ]]
                then
                    columnNum=$(($REPLY+1))
                    columnName=$choice
                    clear # formating
                    echo "Your answer saved Successfully "
                    break 2
                else
                    clear # formating
                    echo -e "\nError: wrong choice\nTry Again\n"
                    sleep 2
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
        clear # formating
        echo "$updateNumber Record Updated Successfully"
    else
        clear # formating
        echo "No Records Matched"
    fi
}