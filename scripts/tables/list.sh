#!/bin/bash

: '
Author : Khaled Gad
Description : List all tables in the database 
'

shopt -s extglob
export LC_COLLATE=C

listTables(){
    echo "hello from list tables"
}
# listTables