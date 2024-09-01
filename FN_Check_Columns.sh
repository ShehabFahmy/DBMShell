#!/bin/bash

db_name=$1
db_path=$2
tb_name=$3
colName=$4

# db_name="tst"
# db_path="/media/sheko/0AECA6ECECA6D16D/Ubuntu-Desktop/Bash-Project/tst"
# tb_name="tt"
# colName="c1"

# Check for column name
output=$(cat "$db_path"/.DB_Data/"$tb_name"-md.txt | grep \;$colName\;)

# Return its index in metadata file
if [ -z $output ]; then
    echo 0
else
    echo $output | awk -F ";" '{print $1}'
fi