#!/bin/bash

: '
Author : Khaled Gad
Date : 10/2/2023 23:00 PM
Description : print any menu by passing its title and array of choices

param 1: title of the menu (string)
param 2: take input after menu or not (0 or 1)
    - 0 to take choice from user and return it
    - 1 to just print menu
param 3: array of choices
'

repeat(){
    local c=$1
    local n=$2
    local i=0
    for (( ; i<$n; i++)); do
        echo -n "$c"
    done
}
customMenu(){
    local msg="$1"
    local lineLength=$((${#msg}+5))
    local justPrint="$2"
    shift
    shift
    local arr=("$@")
    local arrLength=${#arr[*]}

    # start of dashed line
    echo -n "+"
    repeat "-" $lineLength
    echo "+"
    
    # start of title line
    echo -n "| "
    echo -n "$msg"
    repeat " " 4
    echo "|"

    # start of dashed line
    echo -n "+"
    repeat "-" $lineLength
    echo "+"

    #start of menu
    local i=1
    for (( ; i<=$arrLength; i++)); do
        echo -n "| "
        local idx=$(($i-1))
        choice="$i - ${arr[$idx]}"
        echo -n "$choice"
        repeat " " $(($lineLength-${#choice}-1))
        echo "|"
    done
    

    # start of dashed line
    echo -n "+"
    repeat "-" $lineLength
    echo "+"

    if [ $justPrint -eq "0" ];then
        # user number datatype to convert any string to 0 by default and ignore it
        typeset -i choice

        read -p "choice : " choice
        return $choice
    fi
}
#a=("khaled" "gad" "elafandy")
#customMenu "choose you database that you want to print" ${a[*]}