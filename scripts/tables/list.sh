#!/bin/bash

: '
Author : Khaled Gad
Date : 4/2/2023 05:25 PM
Description : List all tables in the database 
'

# This vars needed when test file without table-menu
#dbName="test"  
#dbLocation="../../Databases/$dbName"

shopt -s extglob
export LC_COLLATE=C

listTables(){
    tables=$(ls $dbLocation)
    
    echo "+--------------------------------+"
    echo "|           Table Name           |"
    for i in $(ls $dbLocation)
    do
        echo "+--------------------------------+"
        echo -n +
        j=0
        let dashes=(32-${#i})/2
        #echo dashes $dashes
        let remain=32-dashes-dashes-${#i}
        #echo remain $remain
        while [[ $j -lt $dashes ]]; do
            echo -n " "
            let j=j+1
        done
        echo -n $i
        j=0
        let dashes=dashes+remain
        #echo dashes $dashes
        while [[ $j -lt $dashes ]]; do
            echo -n " "
            let j=j+1
        done
        echo +
    done
    echo "+--------------------------------+"
}
#listTables