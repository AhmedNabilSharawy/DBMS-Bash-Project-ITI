#!/bin/bash

#Author : Ahmed Nabil
#Description: Display Database based on user input

shopt -s extglob
export LC_COLLATE=C

#check Database Entered exists
while [ true ]; do
    read -p "Enter Database Name: " DbName
    # -n $DbName checks that input is not empty because if enter was pressed all databases will be displayed
    if [[ -d ~/DBMS-Bash-Project-ITI/Databases/"$DbName" && -n $DbName ]]; then
        clear
        ls ~/DBMS-Bash-Project-ITI/Databases/$DbName 

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
