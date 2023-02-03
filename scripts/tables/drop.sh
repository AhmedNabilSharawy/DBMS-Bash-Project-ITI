#!/bin/bash

: '
Author : Khaled Gad
Description : Drop all data from table but keep the structure 
'

shopt -s extglob
export LC_COLLATE=C

dropTable(){
    echo "hello from drop table"
}
# dropTable