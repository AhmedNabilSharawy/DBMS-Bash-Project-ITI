#!/bin/bash

#Author : Ahmed Nabil
#Description: Drop Database based on user input

shopt -s extglob
export LC_COLLATE=C

#check Database Entered exists
while [ true ]; do
    read -p "Enter Database Name: " DbName
    # -n $DbName checks that input is not empty because if enter was pressed all database will be deleted
    if [[ -d ~/DBMS-Bash-Project-ITI/Databases/"$DbName" && -n $DbName ]]; then
        rm -r  ~/DBMS-Bash-Project-ITI/Databases/$DbName 
        clear
        echo "Database $DbName removed successfully"

        PS3="Choose Number From Menu PLease: "
        select choice in "Back to Main Menu" "Exit"
            do
                if [[ $REPLY =~ ^[1-2]+$ ]] ;then
                    case $REPLY in 
                        1) clear
                            . ~/DBMS-Bash-Project-ITI/main-menu.sh
                            break ;;
                        2) exit ;;
                    esac
                else
                    echo "You have Entered Wrong Number"
                fi
            done
            break
    else
        echo "Database Doesn't Exist"
    fi
done
