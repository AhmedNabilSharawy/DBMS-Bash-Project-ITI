#!/bin/bash

: '
Author : Khaled Gad
Date : 11/2/2023 14:00 PM
Description : get database from a menu and validate the choice
'

getTable(){
    
    local tables=($(ls $dbLocation))
    local tablesLength=${#tables[@]}
    local title=$1
    [[ $tablesLength -eq 0 ]] && echo "$dbName database is empty" && return 2
    while true; do
        printf "\n"
        customMenu "$title" 0 "${tables[@]}" "Back to Main-Menu" "Exit"
        local choice=$?
        if [[ $choice -gt 0 && $choice -le $tablesLength ]]; then
            let choice=$choice-1
            tableName="${tables[$choice]}"
            break
        elif [[ $choice -eq $(($tablesLength+1)) ]]; then
            return 2
        elif [[ $choice -eq $(($tablesLength+2)) ]]; then
            exit 0
        else
            echo -e "\nInvalid Value: The value must be between (1, $(($tablesLength+2)))"
        fi
    done
}