#!/bin/bash

#Author : Ahmed Nabil
#Description: Connect to Database based on user input

shopt -s extglob
export LC_COLLATE=C

#check Database Entered exists
while [ true ]; do
    read -p "Enter Database Name: " DbName
    # -n $DbName checks that input is not empty because if enter was pressed will connect to blank database 
        cd ~/DBMS-Bash-Project-ITI/Databases/$DbName 
        clear
        echo "Database $DbName Connected successfully"

        PS3="Choose Number From Menu PLease: "
        select choice in "Create Table" "List Tables" "Drop Table" "Insert into Table" "Select from Table" "Delete from Table" "Update Table" "Back to Main Menu" "Exit"
            do
                if [[ $REPLY =~ ^[1-9]+$ ]] ;then
                    case $REPLY in 
                        1) . ~/DBMS-Bash-Project-ITI/scripts/tables/create.sh
                            break ;;
                        2) . ~/DBMS-Bash-Project-ITI/scripts/tables/list.sh
                            break ;;
                        3) . ~/DBMS-Bash-Project-ITI/scripts/tables/drop.sh
                            break ;;
                        4) . ~/DBMS-Bash-Project-ITI/scripts/tables/insert.sh
                            break ;;
                        5) . ~/DBMS-Bash-Project-ITI/scripts/tables/select.sh
                            break ;;
                        6) . ~/DBMS-Bash-Project-ITI/scripts/tables/delete.sh
                            break ;;
                        7) . ~/DBMS-Bash-Project-ITI/scripts/tables/update.sh
                            break ;;
                        8) clear
                            . ~/DBMS-Bash-Project-ITI/main-menu.sh
                            break ;;
                        9) exit ;;
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
