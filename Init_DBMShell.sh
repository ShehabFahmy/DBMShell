#!/bin/bash

echo -e "\t\t\t ============================"
echo -e "\t\t\t ||  Welcome to DBMShell!  ||"
echo -e "\t\t\t ============================"

chmod +x Main_Menu.sh
chmod +x Create_Database.sh
chmod +x List_Databases.sh
chmod +x Connect_Database.sh
chmod +x Drop_Database.sh
chmod +x DB_Interface.sh
chmod +x DB_Create_Table.sh
chmod +x DB_List_Tables.sh
chmod +x DB_Drop_Table.sh
chmod +x DB_Insert_Into_Table.sh
chmod +x DB_Select_From_Table.sh
chmod +x DB_Delete_From_Table.sh
chmod +x DB_Update_Table.sh
chmod +x FN_Check_Columns.sh
mkdir -p .Data

./Main_Menu.sh