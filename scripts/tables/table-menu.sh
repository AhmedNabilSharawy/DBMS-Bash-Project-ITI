#!/bin/bash

#SCRIPTPATH=`dirname "$0"` ---> will be needed in integration with the database files

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

# import printTableInfo function from tables/printTableInfo scripts
source ./scripts/tables/print-table.sh

# import updateFromTable function from tables/printTableInfo scripts
source ./scripts/tables/update.sh

tableMenu(){
    local dbName=$1
    local dbLocation="Databases/$dbName"
    tableMenuOptions=( "List Tables" "Create Table" "Drop Table" "Select from Table" "Insert into Table" "Update Table" "Delete from Table" "Back to Main Menu" "Exit" )
    while true; do
        clear
        customMenu "      Connected to $dbName  " 0 "${tableMenuOptions[@]}"
        local choice=$?
        case $choice in
            1) listTables ;; #Done
            2) createNewTable ;; #Done
            3) dropTable ;; #in progress
            4) selectFromTable ;;
            5) insertData ;;
            6) updateFromTable; break;;
            7) deleteFromTable; break;;
            8) break ;;
            9) exit 0 ;;
            *) echo -e "\nError: The value must be between (1, ${#tableMenuOptions[*]})\n";
        esac
        read -p "Press any key to continue..."
    done
}