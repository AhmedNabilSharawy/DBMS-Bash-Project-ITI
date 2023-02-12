#!/bin/bash
: '
Author : Ahmed Nabil
Date : 04-02-2023
Description: Main Menu for DBMS

Test Cases covered:
1- User input within Range of select.
'
# import customMenu function from /scripts/custom-menu.sh script
source ./scripts/custom-menu.sh

# import dropDB function from /scripts/db/drop.sh script
source ./scripts/db/create.sh  

# import dropDB function from /scripts/db/drop.sh script
source ./scripts/db/drop.sh

# import listDB function from /scripts/db/list.sh script
source ./scripts/db/list.sh 

# import connectDB function from /scripts/db/connect.sh script
source ./scripts/db/connect.sh 

shopt -s extglob
export LC_COLLATE=C

askMenuWithCont(){
    while true; do
        PS3="Choose Number From Menu PLease: "
        select choice in "Continue" "Back to Main Menu" "Exit"
        do
            case $REPLY in 
            1) clear #formating 
                break 2;;
            2) clear #formating 
                . ./main-menu.sh
                break ;;
            3) clear #formating 
                echo "Good Bye, Have a nice Day!"
                exit ;;
            *) clear #formating 
                echo "You have Entered Wrong Number!" 
                echo #formating new line 
                continue 2 ;;
            esac
        done
    done
}

askMenuWithoutCont(){
    while true; do
        select choice in "Back to Main Menu" "Exit"
            do
                case $REPLY in 
                    1) clear #formating 
                        . ./main-menu.sh
                        break 2 ;;
                    2) clear #formating 
                    echo "Good Bye, Have a nice Day!"
                    exit ;;
                    *) clear #formating 
                    echo "You have Entered Wrong Number!" 
                    echo #formating new line
                    continue 2 ;;
                esac
            done
    done  
}

while true; do
    PS3="Choose Number From Menu PLease: "
    select choice in "Create Database" "List Databases" "Connect To Databases" "Drop Database" "Exit"
    do
        case $REPLY in 
            1) clear #formating 
                createDb ;;
            2) clear
               listDB ;;
            3) clear #formating 
                clear
                connectDB
                ;;
            4) clear #formating 
                clear
                dropDB
                ;;
            5) clear #formating 
               echo "Good Bye, Have a nice Day!"
               exit ;;
            *) echo "You have Entered Wrong Number"
        esac
        clear #formating 
        break
    done
done

