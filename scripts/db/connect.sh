#!/bin/bash
: '
Author : Ahmed Nabil
Date : 04-02-2023
Description: Connect to Database based on user Select

Test Cases covered:
1- Check Database is existed.
2- Empty input is handeled.
3- User input within Range of select.
'
shopt -s extglob
export LC_COLLATE=C

# import tableMenu function from /scripts/tables/table-menu.sh script
source ./scripts/tables/table-menu.sh 

connectDB(){
    if [[ -d ./Databases ]];then
        local dbs=$(ls ./Databases)
        local dbsCount=$(ls ./Databases | wc -l)
        
        while true; do
            if [[ dbsCount -gt 0 ]]; then
                PS3="Choose Database you want to Connect please: "
                select choice in $dbs
                do
                    if [[ $REPLY -ge 1 && $REPLY -le $dbsCount ]]
                    then
                    # passing database name to tableMenu function
                        tableMenu $choice
                        
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