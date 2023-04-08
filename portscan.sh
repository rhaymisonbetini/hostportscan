#!/usr/bin/env bash

RED='\033[0;31m'
NC='\033[0m'
BBlue='\033[1;34m' 

printf "${RED} _     _  _____    _    _______    ______   _____  ______  _______       _     ______        ______  
| |   | |/ ___ \  | |  (_______)  (_____ \ / ___ \(_____ \(_______)     | |   / _____)  /\  |  ___ \ 
| |__ | | |   | |  \ \  _          _____) ) |   | |_____) )_             \ \ | /       /  \ | |   | |
|  __)| | |   | |   \ \| |        |  ____/| |   | (_____ (| |             \ \| |      / /\ \| |   | |
| |   | | |___| |____) ) |_____   | |     | |___| |     | | |_____    _____) ) \_____| |__| | |   | |
|_|   |_|\_____(______/ \______)  |_|      \_____/      |_|\______)  (______/ \______)______|_|   |_|${NC} \n\n\n"

printf "${BBlue}##################################################################
#Script Name	:
#Description	:
#Args           :
#Author       	:
#Email         	:
################################################################### \n\n"

echo "SCOKET SCAN"
echo "TYPE YOU SCAN CHOICE"
echo "---------------------------------"
echo "[1] - Scan avalible host"
echo "[2] - Scan avalible port in hosts"
echo "[3] - Scan avalible postn in host" 

read choice

if [ $choice == "1" ]
then
	read -p "INSER TARGET EX:192.168.1 : " main
	read -p "INSER INITAL: " init
	read -p "INSET LIMIT: "  final

	if [ $init -ge 1 -a $final -le 254  -a main != "" ]
		then
			for host in `seq $init $final`
				do
					hping3 -S -p 80 -c 1 $main.$host 2> /dev/null | grep "flags=SA" 
				done
					echo "SCAN FINISH!" 
		else
			echo "INVALID VALUES FOR INTERVAL"
		fi

elif [ $choice == "2" ]
then
	echo"2"
elif [ $choice == "3" ]
then
	echo "3"
fi
