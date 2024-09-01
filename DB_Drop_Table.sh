#!/bin/bash

db_name=$1
db_path=$2

echo "!! You chose to drop a table !!"

echo "!! HINT: You can enter the table's name or number !!"
while true; do
    read -p "DROP TABLE: " tb_name
    echo -en "\033[A\033[K"
    echo "DROP TABLE $tb_name;"
    if [[ $tb_name =~ ^[0-9]*[a-zA-Z]+[0-9]*$ ]]; then
        if [ $(ls $db_path | grep -i $tb_name | wc -l) -ne 0 ]; then
            fail=0; break
        else
            echo "!! This Table Doesn't Exist !!"
        fi
    elif [[ $tb_name =~ ^[0-9]+$ ]]; then
        if [ $tb_name -le $(ls $db_path | wc -l) ]; then
            tb_name=$(ls $db_path -1 | nl | sed "s/.txt//" | grep $tb_name | awk '{print $2}')
            fail=0; break
        else
            echo "!! This Table Doesn't Exist !!"
        fi
    else        
        fail=1; break
    fi
done

if [ $fail -eq 0 ]; then
    read -p "You are about to drop $tb_name, proceed? (y/n) " choice
    if [[ $choice =~ ^y|Y|[yY][eE][sS]$ ]]; then
        echo -n "Dropping $tb_name.";
        sleep 1; rm $db_path/$tb_name.txt; echo -n ".";
        sleep 1; rm $db_path/.DB_Data/"$tb_name"-md.txt; echo "."
        echo "!! Table Dropped !!"
    else
        echo "!! Operation Cancelled !!"
    fi
elif [ $fail -eq 1 ]; then
    echo "!! Invalid Input !!"
fi
echo -n "Returning to Operations Menu."; sleep 1;
echo -n "."; sleep 1; echo ".";
./DB_Interface.sh $1 $2