#!/bin/bash
: '
Author : Ahmed Nabil
Date : 04-02-2023
Description: Main Menu for DBMS

Test Cases covered:
1- User input within Range of select.
'
shopt -s extglob
export LC_COLLATE=C

askMenuWithCont(){
    PS3="Choose Number From Menu PLease: "
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
}

askMenuWithoutCont(){
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
}

PS3="Choose Number From Menu PLease: "
select choice in "Create Database" "List Databases" "Connect To Databases" "Drop Database" "Exit"
    do
        case $REPLY in 
            1) clear #formating 
                . ./scripts/db/create.sh
                break ;;
            2) clear #formating 
                . ./scripts/db/list.sh 
                break ;;
            3) clear #formating 
                . ./scripts/db/connect.sh 
                break ;;
            4) clear #formating 
                . ./scripts/db/drop.sh 
                break ;;
            5) clear #formating 
               echo "Good Bye, Have a nice Day!"
               exit ;;
            *) echo "You have Entered Wrong Number"
        esac
    done

