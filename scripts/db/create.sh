#!/bin/bash

: '
Author : Ahmed Nabil
Description: Create Database based on user input

Test Cases covered:
1- Check Duplication of Database is Handeled.
2- Empty input is handeled.
3- WhiteSpaces in Database Name is prevented.
4- Database naming convention follows alphabitical naming and includes Underscore(_) at the middle only.
'
shopt -s extglob
export LC_COLLATE=C

# check that Database Directory exists if not will create one
if [ -d Databases ]; then
    : # no operation command in shell
else
    mkdir Databases
fi
# create Database from user
while [ true ]; do
echo "Database Name should be Alphabets Only and (_) is optional in the middle"
read -p "Enter Database Name: " DbName
# check Duplication of Database
    # if [[ -d ~/DBMS-Bash-Project-ITI/Databases/"$DbName" && -n $DbName ]]; then
    if [[ -d ./Databases/"$DbName" && -n $DbName ]]; then

        clear #formating

        echo "$DbName Already Exists"
        select choice in "Continue" "Back to Main Menu" "Exit"
            do
                case $REPLY in 
                1) clear #formating 
                    break;;
                2) clear #formating 
                    . ./main-menu.sh
                    break ;;
                3) echo "Good Bye"
                   exit ;;
                *) echo "You have Entered Wrong Number" ;;
                esac
            done
    else
        if [[ $DbName =~ ^[a-zA-Z]+_{0,1}[a-zA-Z]+$ && -n $DbName ]]; then
            mkdir ./Databases/$DbName

            clear #formating 

            echo "$DbName Created successfully"
            PS3="Choose Number From Menu PLease: "
            select choice in "Back to Main Menu" "Exit"
                do
                    case $REPLY in 
                    1) clear #formating 
                       . ./main-menu.sh
                       break ;;
                    2) clear #formating 
                       echo "Good Bye, Have a nice Day!"
                       exit ;;
                    *) echo "You have Entered Wrong Number" ;;
                    esac
            done
            break #break while loop
        else
            clear #formating 
            echo "Database Name invalid"
            select choice in "Continue" "Back to Main Menu" "Exit"
            do
                case $REPLY in 
                1) clear #formating 
                    break;;
                2) clear #formating 
                    . ./main-menu.sh
                    break ;;
                3) clear #formating 
                   echo "Good Bye, Have a nice Day!"
                   exit ;;
                *) echo "You have Entered Wrong Number" ;;
                esac
            done 
        fi
    fi
done





