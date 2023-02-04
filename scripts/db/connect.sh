#!/bin/bash
: '
Author : Ahmed Nabil
Description: Connect to Database based on user input

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

# -n $DbName checks that input is not empty because if enter was pressed will connect to blank database 
if [[ -d ./Databases/"$DbName" && -n $DbName ]]; then
    cd ./Databases/$DbName 
    clear
    echo "Database $DbName Connected successfully"

    PS3="Choose Number From Menu PLease: "
    select choice in "Create Table" "List Tables" "Drop Table" "Insert into Table" "Select from Table" "Delete from Table" "Update Table" "Back to Main Menu" "Exit"
        do
            case $REPLY in 
                1) clear #formating 
                    . ./scripts/tables/create.sh
                    break ;;
                2) clear #formating 
                    . ./scripts/tables/list.sh
                    break ;;
                3) clear #formating 
                    . ./scripts/tables/drop.sh
                    break ;;
                4) clear #formating 
                    . ./scripts/tables/insert.sh
                    break ;;
                5) clear #formating 
                    . ./scripts/tables/select.sh
                    break ;;
                6) clear #formating 
                    . ./scripts/tables/delete.sh
                    break ;;
                7) clear #formating 
                    . ./scripts/tables/update.sh
                    break ;;
                8) clear #formating 
                    cd ../..
                    . ./main-menu.sh
                    break ;;
                9) clear #formating 
                   echo "Good Bye, Have a nice Day!"
                   exit ;;
                *) echo "You have Entered Wrong Number"
            esac
        done
            break # break while loop
    else
        clear #formating 
        echo "Database Doesn't Exist"
        select choice in "Continue" "Back to Main Menu" "Exit"
            do
                case $REPLY in 
                1) clear #formating 
                    break;;
                2) clear #formating 
                    cd ../..
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
