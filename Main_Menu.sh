#!/bin/bash

echo ">----------------------------------------------------------------<"
echo "= Please choose a number from 1 to 4 for the following features: ="
echo ">----------------------------------------------------------------<"
echo " 1) Create Database"
echo " 2) List Databases"
echo " 3) Connect to Database"
echo " 4) Drop Database"

read -p "> " choice
case $choice in
    1)
        ./Create_Database.sh;;
    2)
        ./List_Databases.sh;;
    3)
        ./Connect_Database.sh;;
    4)
        ./Drop_Database.sh;;
    *)
        echo -n "Invalid Input! Exiting."; sleep 1;
        echo -n "."; sleep 1; echo ".";;
esac