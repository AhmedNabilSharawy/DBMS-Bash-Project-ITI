#!/bin/bash

: '
Author : Khaled Gad
Date : 10/2/2023 06:00 PM
Description : Select specific data from table 
'

chooseColumns(){
    local marked=()
    local columnsSize=${#tableColumns[@]}
    while true; do
        # multi selected menu for columns
        # --------------------- start of menu ------------------ #
        echo -e "\nChoose which columns you want to display"
        for ((i=0;i<$columnsSize;i++))
        do
            echo "[${marked[$i]:- }] $((($i+1)))) ${tableColumns[$i]}"
        done
        echo "[${marked[$i]:- }] $((($i+1)))) All"

        # print message if it exists
        [[ "$msg" ]] && echo "$msg"

        read -p "choice [press ENTER when finish] : " choice
        # --------------------- end of menu -------------------- #

        # break if user enter an Enter key and menu is not empty
        if [[ $choice == "" ]]; then
            if [[ ${#marked[@]} -gt 0 ]]; then
                break
            else
                echo -e "\nInvalid Value : You must choose at least one column to display"
                continue
            fi
        fi

        # Check if the choice in the valid range
        if [[ $choice -gt 0 && $choice -le $columnsSize ]]; then
            let choice=choice-1
            msg="${tableColumns[choice]} was ${marked[choice]:+un}checked"
            # check if this choice is selected or not (if marked[choice value is empty or +])
            [[ "${marked[$choice]}" ]] && marked[choice]="" || marked[choice]="+"
        elif [[ $choice -eq $(($columnsSize+1)) ]]; then
            echo -e "\nAll columns have been selected"
            for ((i=0;i<$columnsSize;i++)); do
                [[ "${marked[$i]}" ]] || marked[$i]="+"            
            done
            break
        else
            msg="Invalid option: $choice"
        fi
    done
    for i in ${!tableColumns[@]}; do
        if [[ "${marked[i]}" ]]
        then
            # save columns name
            selectedColumnName[$i]="${tableColumns[i]}"

            # save indexes of chosen columns 
            let selectedColumnIdx[$i]=$i+1
        fi
    done
    
}

selectFromTable(){
    # Menu to let user select specific table from list of tables in database

    local tableName=""
    local selectedColumnIdx=("")
    local selectedColumnName=("")
    
    printf "\n"
    getTable "Select table that you want to get data from"
    [ $? -eq 2 ] && return

    # Menu to let user choose which columns to display
    local tableColumns=("_id" $(cut -f1 -d: $dbLocation/.meta-$tableName))
    chooseColumns

    # Menu to let user select rows based on conditions
    echo -e "\nSet condition to select rows based on it"
    echo "In which column you want to set condition"

    while true; do
        customMenu "SELECT ${selectedColumnName[*]} FROM $tableName WHERE " 0 "${tableColumns[@]}" 
        choice=$?
        if [[ $choice -gt 0 && $choice -le ${#tableColumns[@]} ]]
        then
            # get value from user that he want to put condition based on it
            printf "\n"
            read -p "${tableColumns[$(($choice-1))]} = " value
            break
        else
            echo -e "\nInvalid option: out of range\n"
        fi
    done
    printf "\n"
    awk -F: -v c="${selectedColumnIdx[*]}" -v r=$choice -v v=$value '
        BEGIN{ split(c, a, " ") }
        {
            if($r == v){
                for(i in a) {
                    printf "%s ",$a[i];
                }
                printf "\n"
            }
        }' $dbLocation/$tableName
    
    echo ""
}
