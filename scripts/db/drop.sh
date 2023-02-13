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
        
        while [ true ]; do
            if [[ dbsCount -gt 0 ]]; then
                PS3="Choose Database you want to Drop please: "
                select choice in $dbs
                do
                    if [[ $REPLY -ge 1 && $REPLY -le $dbsCount ]]
                    then
                    # Drop Statement
                        rm -r ./Databases/$choice
                        clear #formating
                        echo -e "Database $choice removed Successfully \n"
                        askMenuWithoutCont
                    else
                        clear #formating
                        echo -e "Invalid Number, please enter number from 1 to $dbsCount:\n"

                        continue 2
                    fi
                done
            else
                echo -e "Databases is empty \n"
                askMenuWithoutCont
            fi
        done
    else
        echo -e "No Databases created yet! \n"

        askMenuWithoutCont
    fi
    
}
