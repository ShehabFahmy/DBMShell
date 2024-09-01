#!/bin/bash

db_name=$1
db_path=$2

echo "!! You chose to update a table !!"

echo "Update Table Syntax:
    +++++++++++++++++++++++++
    + UPDATE table_name     +
    + SET column1 = value1, +
    +     column2 = value2, +
    +     ...               +
    + WHERE condition;      +
    +++++++++++++++++++++++++"

fail_cnt=0
while true;
do
    read -p "UPDATE [table_name]: " tb_name
    if [ $fail_cnt -gt 0 ]; then
        echo -en "\033[A\033[K" # Remove the last line
        echo -en "\033[A\033[K" # Remove the last line
        echo -en "\033[A\033[K" # Remove the last line
        echo "UPDATE [table_name]: $tb_name"
        (( fail_cnt-- ))
    fi
    x=$(ls $db_path | grep -i $tb_name.txt | wc -l)
    if [ $x == 0 ]; then
        (( fail_cnt++ ))
        echo "!! This Table Doesn't Exist !!"
    else
        break
    fi
done
echo -en "\033[A\033[K" # Remove the last line
echo "UPDATE $tb_name"
echo "!! HINT: Put a comma after the value to set another column !!"
i=1
fail_cnt=0
# metadata_buffer=$(mktemp)
while true;
do
    if [ $i -eq 1 ]; then
        prefix="SET"
    else
        prefix="   "
    fi
    
    while true;
    do
        read -p "$prefix [column$i]: " column
        if [ $fail_cnt -gt 0 ]; then
            echo -en "\033[A\033[K" # Remove the last line
            echo -en "\033[A\033[K" # Remove the last line
            echo -en "\033[A\033[K" # Remove the last line
            echo "$prefix [column$i]: $column"
            (( fail_cnt-- ))
        fi
        isColExist=$(./FN_Check_Columns.sh $1 $2 $tb_name $column)
        IFS=',' read -r colIndex <<< $isColExist
        if [ $colIndex -eq 0 ]; then
            (( fail_cnt++ ))
            echo "!! This Column Doesn't Exist !!"
        else
            break
        fi
    done
    echo -en "\033[A\033[K"
    read -p "$prefix $column = [value$i]: " value    
    echo -en "\033[A\033[K" # Remove the last line
    if [ $i -eq 1 ]; then
        echo -en "\033[A\033[K" # Remove the hint
    fi
    echo "$prefix $column = $value"

    lastChar=${value:${#value}-1:1}
    if [ $lastChar != "," ]; then
        # echo "$i;$column;$value" >> $metadata_buffer
        break
    # else
        # echo "$i;$column;${value:0:${#value}-1}" >> $metadata_buffer
    fi
    (( i++ ))    
done
read -p "WHERE [condition]: " condition
echo -en "\033[A\033[K"
echo "WHERE $condition;"

# # Execute the script and capture its output
# output=$(./FN_Check_Columns.sh)

# # Split the output into variables using IFS (Internal Field Separator)
# IFS=',' read -r var1 var2 var3 <<< "$output"

# # Use the variables
# echo "Var1: $var1"
# echo "Var2: $var2"
# echo "Var3: $var3"
