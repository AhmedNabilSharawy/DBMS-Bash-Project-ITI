#!/bin/bash

: '
Author : Khaled Gad
Date : 10/2/2023 06:00 PM
Description : Select specific data from table 
'

shopt -s extglob
export LC_COLLATE=C

# This vars needed when test file without table-menu
dbName="test"  
dbLocation="../../Databases/$dbName"

tableName=""
tableMetaFile=""

chooseTable(){
    tables=$(ls $dbLocation)
    tablesLength=$(ls $dbLocation | wc -l)
    # while loop to keep printing menu in the case of error happened 
    while true; do
        PS3="---> "
        select choice in $tables
        do
            if [[ $REPLY -ge 1 && $REPLY -le $tablesLength ]]
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

chooseColumns(){
    # Get columns names from meta file of table
    tableColumns=($(cut -f1 -d: $dbLocation/.meta-$tableName))
    marked=("")
    while true; do
        # multi selected menu for columns
        # --------------------- start of menu ------------------ #
        echo -e "\nChoose which columns you want to display"
        for i in ${!tableColumns[@]}
        do
            echo "[${marked[$i]:- }] $((($i+1)))) ${tableColumns[$i]}"
        done

        # print message if it exists
        [[ "$msg" ]] && echo "$msg"

        read -p "---> " choice
        # --------------------- end of menu -------------------- #

        # break if user enter an Enter key
        [[ $choice == "" ]] && break

        # Check if the choice in the valid range
        if [[ $choice -gt 0 && $choice -le ${#tableColumns[@]} ]]
        then
            let choice=choice-1
            msg="${tableColumns[choice]} was ${marked[choice]:+un}checked"
            # check if this choice is selected or not (if marked[choice value is empty or +])
            [[ "${marked[choice]}" ]] && marked[choice]="" || marked[choice]="+"
        else
            msg="Invalid option: $choice"
        fi
    done
    selected=("")
    for i in ${!tableColumns[@]}; do
        if [[ "${marked[i]}" ]]
        then
            # save columns name
            #selected[$i]="${tableColumns[i]}"

            # save indexes of chosen columns 
            let selected[$i]=$i+1
        fi
    done
    #echo "${selected[@]}"
    
}

# conditions(){
#     return 0
# }

selectFromTable(){
    # Menu to let user select specific table from list of tables in database
    echo "Select table that you want to get data from"
    chooseTable
    # Menu to let user choose which columns to display
    chooseColumns
    # Menu to let user select rows based on conditions
    echo "Set condition to select rows based on it"
    echo "In which column you want to set condition"
    while true; do
        PS3="---> "
        select column in ${tableColumns[@]}
        do
            if [[ $REPLY -gt 0 && $REPLY -le ${#tableColumns[@]} ]]
            then
                # get value from user that he want to put condition based on it
                read -p "Enter value of $column: " value
                break 2
            else
                echo -e "\nInvalid option: out of range\n"
            fi
        done
    done
    echo
    awk -F: -v c="${selected[*]}" -v r=$REPLY -v v=$value '
        BEGIN{ split(c, a, " ") }
        {
            if($(r+1) == v){
                for(i in a) {
                    printf "%s ",$(a[i]+1);
                }
                printf "\n"
            }
        }' $dbLocation/$tableName
    
    echo ""
}
selectFromTable

: '
1- but tables in menu and select table which i want to select data from 
2- 
'