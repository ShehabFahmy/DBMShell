#!/bin/bash

db_name=$1
db_path=$2

echo "!! You chose to create a table !!"

echo "Create Table Syntax:
    +++++++++++++++++++++++++++++
    + CREATE TABLE table_name ( +
    +     column1 datatype,     +
    +     column2 datatype,     +
    +     ...                   +
    + );                        +
    +++++++++++++++++++++++++++++"

fail_cnt=0
while true;
do
    read -p "CREATE TABLE: " tb_name
    if [ $fail_cnt -gt 0 ]; then
        echo -en "\033[A\033[K" # Remove the last line
        echo -en "\033[A\033[K" # Remove the last line
        echo -en "\033[A\033[K" # Remove the last line
        echo "CREATE TABLE: $tb_name"
        (( fail_cnt-- ))
    fi
    x=$(ls $db_path | grep -i $tb_name.txt | wc -l)
    if [ $x != 0 ]; then
        (( fail_cnt++ ))
        echo "!! This Table Already Exists !!"
    else
        break
    fi
done
echo -en "\033[A\033[K" # Remove the last line
echo "CREATE TABLE $tb_name ("
echo "!! HINT: Column1 is the primary key !!"
echo "!! HINT: Put a comma after the datatype to insert another column !!"
i=1
metadata_buffer=$(mktemp)
while true;
do
    read -p "   [column$i]: " column        
    echo -en "\033[A\033[K"
    read -p "   $column [datatype]: " datatype
    # Remove the hints
    if [ $i -eq 1 ]; then
        echo -en "\033[A\033[K"
        echo -en "\033[A\033[K"
    fi
    echo -en "\033[A\033[K"
    echo "   $column $datatype"
    lastChar=${datatype:${#datatype}-1:1}
    if [ $lastChar != "," ]; then
        echo "$i;$column;$datatype" >> $metadata_buffer
        break
    else
        echo "$i;$column;${datatype:0:${#datatype}-1}" >> $metadata_buffer
    fi
    (( i++ ))
done
echo ");"

read -p "You are about to create the above table, proceed? (y/n) " choice
if [[ $choice =~ ^y|Y|[yY][eE][sS]$ ]]; then
    touch $db_path/$tb_name.txt;
    mv "$metadata_buffer" "$db_path/.DB_Data/"$tb_name"-md.txt";
    echo "!! Table Created !!"
else
    echo "!! Operation Cancelled !!"
fi
echo -n "Returning to Operations Menu."; sleep 1;
echo -n "."; sleep 1; echo ".";
./DB_Interface.sh $1 $2