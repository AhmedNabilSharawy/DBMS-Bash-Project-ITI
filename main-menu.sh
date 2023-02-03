#!/bin/bash

#Author : Ahmed Nabil
#Description: Main Menu for DBMS

shopt -s extglob
export LC_COLLATE=C

PS3="Choose Number From Menu PLease: "

select choice in "Create Database" "List Databases" "Connect To Databases" "Drop Database"
do
    if [[ $REPLY =~ ^[1-4]+$ ]] ;then
        case $REPLY in 
        1) . ./scripts/db/create.sh
            break ;;
        2) . ./scripts/db/list.sh
            break ;;
        3) . ./scripts/db/connect.sh
            break ;;
        4) . ./scripts/db/drop.sh
            break ;;
        esac
    else
        echo "You have Entered Wrong Number"
    fi
done

