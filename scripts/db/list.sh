#!/bin/bash
: '
Author : Ahmed Nabil
Date : 04-02-2023
Description: Display Databases 

Test Cases covered:
1- Check Database is empty or not.
'

shopt -s extglob
export LC_COLLATE=C

listDB(){
    if [[ -d ./Databases ]];then       
        if [[ $(ls ./Databases) ]]; then
        
            clear #formating

            ls ./Databases
            echo #formating new line

            #Display menu to user
            askMenuWithoutCont
        else
            clear #formating 
            echo -e "Database is empty \n"
            #Display menu to user
            askMenuWithoutCont
        fi
    else
        echo -e "No Databases created yet! \n"
        askMenuWithoutCont
    fi
}
