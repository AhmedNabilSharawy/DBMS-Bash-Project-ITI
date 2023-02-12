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
dropDB(){
    if [[ -d ./Databases ]];then
        local dbs=$(ls ./Databases)
        local dbsCount=$(ls ./Databases | wc -l)
        
        while true; do
            if [[ dbsCount -gt 0 ]]; then
                PS3="Choose Database you want to Drop please: "
                select choice in $dbs
                do
                    if [[ $REPLY -ge 1 && $REPLY -le $dbsCount ]]
                    then
                    # Drop Statement
                        rm -r ./Databases/$choice
                        clear #formating
                        echo "Database $choice removed Successfully "
                        askMenuWithCont
                    else
                        clear #formating
                        echo "Invalid Number, please enter number from 1 to $dbsCount:"
                        echo #formating new line
                        continue 2
                    fi
                done
            else
                echo "Databases is empty"
                echo #formating new line
                askMenuWithoutCont
            fi
        done
    else
        echo "No Databases created yet!"
        echo #formating new line
        askMenuWithoutCont
    fi
    
}
