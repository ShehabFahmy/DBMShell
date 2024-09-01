#!/bin/bash

echo "!!  You chose to list databases  !!"

databases=$(ls .Data -1 | nl | sed "s/.txt//")
if [[ -z $databases ]]; then
    echo "!! No Databases Yet !!"
else
    echo "$databases"
fi
# ls -1: lists all files, one per line.
# nl: numbers each line of the output.
# sed "s/.txt//": substitutes each ".txt" by ""

echo
./Main_Menu.sh