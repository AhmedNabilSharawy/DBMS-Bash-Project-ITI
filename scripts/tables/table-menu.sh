#!/bin/bash

#SCRIPTPATH=`dirname "$0"` ---> will be needed in integration with the database files

# import listTables function from /tables/list.sh script
source ./list.sh

# import createNewTable function from /tables/create.sh script
source ./create.sh

# import dropTable function from /tables/drop.sh script
source ./drop.sh

# import Select function from /tables/select.sh script
source ./select.sh

# import deleteFromTable function from tables/delete.sh script
source ./delete.sh

# import printTableInfo function from tables/printTableInfo scripts
source ./print-table.sh

dbName="test"
dbLocation="../../Databases/$dbName"

tableMenuOptions=( "List Tables" "Create Table" "Drop Table" "Select from Table" "Insert into Table" "Update Table" "Delete from Table" "Back to Main Menu" "Exit" )

PS3="---> "
while true; do
    clear
    select choice in "${tableMenuOptions[@]}"
    do
        case $REPLY in
            1) listTables ;;
            2) createNewTable ;;
            3) dropTable ;;
            4) selectFromTable ;;
            5) echo "insert into table" ;;
            6) echo "update table" ;;
            7) deleteFromTable; break;;
            8) echo "back to main menu" ;;
            9) echo "exit from script" ;;
            *) echo "wrong choice: Please try again";
        esac
        break
    done
done