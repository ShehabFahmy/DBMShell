#!/bin/bash

db_name=$1
db_path=$2

echo "!! You chose to list all tables !!"

tables=$(ls $db_path -1 | nl | sed "s/.txt//")
if [[ -z $tables ]]; then
    echo "!! No Tables Yet !!"
else
    echo "$tables"
fi
# ls -1: lists all files, one per line.
# nl: numbers each line of the output.
# sed "s/.txt//": substitutes each ".txt" by ""

echo
read -p "!! Press Enter to Return to Operations Menu !!" input
./DB_Interface.sh $1 $2