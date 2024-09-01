#!/bin/bash

echo "!!  You chose to connect to a database  !!"

while true; do
    read -p "Enter Database Name/Number: " db_name
    if [[ $db_name =~ ^[0-9]*[a-zA-Z]+[0-9]*$ ]]; then
        if [ $(ls .Data | grep -i $db_name.txt | wc -l) -ne 0 ]; then
            fail=0; break
        else
            echo "!! This Database Doesn't Exist !!"
        fi
    elif [[ $db_name =~ ^[0-9]+$ ]]; then
        if [ $db_name -le $(ls .Data | wc -l) ]; then
            db_name=$(ls .Data -1 | nl | sed "s/.txt//" | grep $db_name | awk '{print $2}')
            fail=0; break
        else
            echo "!! Invalid Database Number, Please List Databases for the Correct Number !!"
        fi
    else        
        fail=1; break
    fi
done

if [ $fail -eq 0 ]; then
    db_path=$(cat .Data/$db_name.txt | awk '{if (NR == 1) print $0}')
    echo -n "Connecting to $db_name."; sleep 1;
    echo -n "."; sleep 1; echo ".";
    ./DB_Interface.sh $db_name $db_path
elif [ $fail -eq 1 ]; then
    echo "!! Invalid Input !!"
    echo -n "Returning to Main Menu."; sleep 1;
    echo -n "."; sleep 1; echo ".";
    ./Main_Menu.sh
fi