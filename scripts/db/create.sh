#!/bin/bash

: '
Author : Ahmed Nabil
Date : 04-02-2023
Description: Create Database based on user input

Test Cases covered:
1- Check Duplication of Database is Handeled.
2- Empty input is handeled.
3- WhiteSpaces in Database Name is prevented.
4- Database naming convention follows alphabitical naming and includes Underscore(_) at the middle only.
'
shopt -s extglob
export LC_COLLATE=C

createDb(){
    # check that Database Directory exists if not will create one
    if [ -d Databases ]; then
        : # no operation command in shell
    else
        mkdir Databases
    fi

    # create Database from user
    while [ true ]; do
        echo "Database Name should be Alphabets Only and (_) is optional in the middle."
        read -p "Enter Database Name please: " DbName

        # check Duplication of Database
        if [[ -d ./Databases/"$DbName" && -n $DbName ]]; then

            clear #formating

            echo "$DbName Already Exists"
            echo #formating new line

            #Display menu to user
            askMenuWithCont
        else
            if [[ $DbName =~ ^[a-zA-Z]+_?[a-zA-Z]+$ && -n $DbName ]]; then
                mkdir ./Databases/$DbName
                clear #formating 

                echo "$DbName Created successfully"
                echo #formating new line
                
                #Display menu to user
                askMenuWithCont
            else
                clear #formating 
                echo "Database Name invalid"
                echo #formating new line

                #Display menu to user
                askMenuWithCont
            fi
        fi
    done
}






