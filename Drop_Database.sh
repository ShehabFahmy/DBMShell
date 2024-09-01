#!/bin/bash

echo "!!  You chose to drop a database  !!"

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
            echo "!! This Database Doesn't Exist !!"
        fi
    else        
        fail=1; break
    fi
done

if [ $fail -eq 0 ]; then
    # Get the first line, which is the DB path
    db_path=$(cat .Data/$db_name.txt | awk '{if (NR == 1) print $0}')
    echo -n "Dropping $db_name.";
    sleep 1; rm -r $db_path; echo -n ".";
    sleep 1; rm .Data/$db_name.txt; echo "."
    echo "!! Database Dropped !!"
elif [ $fail -eq 1 ]; then
    echo "!! Invalid Input !!"
fi
echo -n "Returning to Main Menu."; sleep 1;
echo -n "."; sleep 1; echo ".";
./Main_Menu.sh