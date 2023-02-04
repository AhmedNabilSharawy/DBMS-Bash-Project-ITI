#!/bin/bash
: '
Author : Ahmed Nabil
Description: Display Database based on user input

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
    # -n $DbName checks that input is not empty 
    if [[ -d ./Databases/"$DbName" && -n $DbName ]]; then
        clear #formating

        ls ./Databases/$DbName 

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
                    *) echo "You have Entered Wrong Number"
                esac
            done
            break #break while loop
    else
        clear #formating 
        echo "Database Doesn't Exist"
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
done
