#!/bin/bash

# similar to ctrl + l without clearing the terminal
echo -e "\033[H\033[2J"

echo ">------------------------------------------------------------------<"
echo "= Please choose a number from 1 to 7 for the following operations: ="
echo ">------------------------------------------------------------------<"
echo " 1) Create Table"
echo " 2) List Tables"
echo " 3) Drop Table"
echo " 4) Insert Into Table"
echo " 5) Select From Table"
echo " 6) Delete From Table"
echo " 7) Update Table"

read -p "> " choice
case $choice in
    1)        
        ./DB_Create_Table.sh $1 $2;;
    2)
        ./DB_List_Tables.sh $1 $2;;
    3)
        ./DB_Drop_Table.sh $1 $2;;
    4)
        ./DB_Insert_Into_Table.sh $1 $2;;
    5)
        ./DB_Select_From_Table.sh $1 $2;;
    6)
        ./DB_Delete_From_Table.sh $1 $2;;
    7)
        ./DB_Update_Table.sh $1 $2;;
    *)
        echo -n "Invalid Input! Returning to Main Menu.";
        sleep 1; echo -n "."; sleep 1; echo "."
        # similar to ctrl + l without clearing the terminal
        echo -e "\033[H\033[2J"
        ./Main_Menu.sh
esac