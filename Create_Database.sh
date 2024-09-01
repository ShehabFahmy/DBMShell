#!/bin/bash

echo "!!  You chose to create a database  !!"

while true;
do
    read -p "Enter DB Name: " db_name
    x=$(ls .Data | grep -i $db_name.txt | wc -l)
    if [ $x != 0 ]; then
        echo "!! This Name Already Exists !!"
    else
        break
    fi
done

echo "Enter Preferred Path (Press Enter for Present Working Directory):"
read -p "> " path
if [ -z $path ]; then
    path=$(pwd)
fi
# Expand the path in case of (~)
extended_path=$(eval echo $path)
echo -n "Creating Database at $extended_path/$db_name."
sleep 1
echo $extended_path/$db_name > .Data/$db_name.txt
echo -n "."
mkdir "$extended_path/$db_name"
mkdir "$extended_path/$db_name/.DB_Data"
echo "."

echo "!! Database Created !!"
echo -n "Returning to Main Menu."; sleep 1; echo -n "."; sleep 1; echo "."
echo
./Main_Menu.sh