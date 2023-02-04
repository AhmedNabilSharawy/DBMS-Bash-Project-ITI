#!/bin/bash
: '
Author : Ahmed Nabil
Date : 04-02-2023
Description: Drop Database based on user input

Test Cases covered:
1- Check user input of Database is existed.
2- Empty input is handeled.
3- User input within Range of select.
'
shopt -s extglob
export LC_COLLATE=C

#check Database Entered exists
while [ true ]; do
    read -p "Enter Database Name: " DbName
    # -n $DbName checks that input is not empty because if enter was pressed all database will be deleted
    if [[ -d ./Databases/"$DbName" && -n $DbName ]]; then
        rm -r ./Databases/$DbName 

        clear #formating 

        echo "Database $DbName removed successfully"
        #Display menu to user
        askMenu
    else
        clear #formating 
        echo "Database Doesn't Exist"
        #Display menu to user
        askMenu
    fi
done
