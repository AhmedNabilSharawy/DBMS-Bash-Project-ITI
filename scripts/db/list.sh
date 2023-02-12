#!/bin/bash
: '
Author : Ahmed Nabil
Date : 04-02-2023
Description: Display Database based on user input

Test Cases covered:
1- Check Database is empty or not.
'

shopt -s extglob
export LC_COLLATE=C

listDB(){
    if [[ -d ./Databases ]];then       # -n $DbName checks that input is not empty 
        if [[ "$(ls ./Databases)" ]]; then
        
            clear #formating

            ls ./Databases
            echo #formating new line

            #Display menu to user
            askMenuWithoutCont
        else
            clear #formating 
            echo "Database is empty"
            echo #formating new line
            #Display menu to user
            askMenuWithoutCont
        fi
    else
        echo "No Databases created yet!"
        echo #formating new line
        askMenuWithoutCont
    fi
}
