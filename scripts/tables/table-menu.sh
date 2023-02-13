#!/bin/bash

: '
Author : Khaled Gad
Date : 3/2/2023 04:00 PM
Description : Menu of all tables operations that can be made on database
'

shopt -s extglob
export LC_COLLATE=C

# import listTables function from /tables/list.sh script
source ./scripts/tables/list.sh

# import createNewTable function from /tables/create.sh script
source ./scripts/tables/create.sh

# import dropTable function from /tables/drop.sh script
source ./scripts/tables/drop.sh

# import Select function from /tables/select.sh script
source ./scripts/tables/select.sh

# import deleteFromTable function from tables/delete.sh script
source ./scripts/tables/delete.sh

# import insertData function from tables/delete.sh script
source ./scripts/tables/insert.sh

# import updateFromTable function from tables/printTableInfo scripts
source ./scripts/tables/update.sh

# import getTable function from tables/get-table.sh script
source ./scripts/tables/get-table.sh

tableMenu(){
    local dbName=$1
    local dbLocation="Databases/$dbName"
    tableMenuOptions=( "List Tables" "Create Table" "Drop Table" "Select from Table" "Insert into Table" "Update Table" "Delete from Table" "Back to Main Menu" "Exit" )
    while true; do
        clear
        customMenu "Connected to $dbName DB" 0 "${tableMenuOptions[@]}"
        local choice=$?
        case $choice in
            1) listTables ;; #Done
            2) createNewTable ;; #Done
            3) dropTable ;; #Done
            4) selectFromTable ;; #Done
            5) insertData ;; #Done
            6) updateFromTable ;;
            7) deleteFromTable ;;
            8) break;;
            9) exit 0 ;;
            *) echo -e "\nError: The value must be between (1, ${#tableMenuOptions[*]})\n";
        esac
        echo ""
        read -p "Press any key to continue..."
    done
}