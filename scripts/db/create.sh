#!/bin/bash

#Author : Ahmed Nabil
#Description: Create Database based on user input

shopt -s extglob
export LC_COLLATE=C

#clear main menu input from terminal
clear 

#check that Database Directory exists if not will create one

if [ -d ~/DBMS-Bash-Project-ITI/Databases ]; then
    : # no operation command in shell
else
    mkdir ~/DBMS-Bash-Project-ITI/Databases
fi
#create Database from user
while [ true ]; do
read -p "Enter Database Name (Alphabets Only Without Spaces): " DbName
# check Duplication of Database
    if [ -d ~/DBMS-Bash-Project-ITI/Databases/"$DbName" ]; then
        echo "$DbName Already Exists"
        continue
# check Database name doesn't include whitespaces   
    elif [[ $DbName = *" "* ]]; then
        echo "Please Remove spaces"
        continue
    else
        if [[ $DbName =~ ^[a-z|A-Z]+$ ]]; then
            mkdir ~/DBMS-Bash-Project-ITI/Databases/$DbName
            echo "$DbName Created successfully"
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
            break #break while loop
        else
            echo "Database Name invalid"
        fi
    fi
done





