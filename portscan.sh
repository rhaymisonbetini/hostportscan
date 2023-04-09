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

echo "SELECT YOU SCAN CHOICE"
echo "---------------------------------"
echo "[1] - Scan avalible host - default port 80"
echo "[2] - Scan avalibles ports in hosts"
echo "[3] - Scan avalible port in hosts" 

read choice

if [ $choice == "1" ]
then
	read -p "INSERT TARGET EX:192.168.1 : " main
	read -p "INSERT INITAL: " init
	read -p "INSERT LIMIT: "  final

	if [ $init -ge 1 -a $final -le 254  -a main != "" ]
		then
			echo "SCAN INIT"
			for host in `seq $init $final`
				do
					hping3 -S -p 80 -c 1 $main.$host 2> /dev/null  
				done
					echo "SCAN FINISH!" 
		else
			echo "INVALID VALUES FOR INTERVAL"
	fi

elif [ $choice == "2" ]
then
	read -p "INSERT THE TARGET EX: 192.157.1.30 : " host
	read -p "INSERT INITAL PORT : " init
	read -p "INSERT FINAL  PORT : " final

	if [ $init -le -1 -o $init  -gt 65535 -o $init == "" ] || [ $final -le -1 -o $final -gt 65535 -o $final == "" ]
		then
		echo "PORT INTERVAL BETWEEN 0 AND 65535"
		else
		echo "INIT SCAN BY PORTS IN HOST: $host"
			for port in `seq $init $final`
				do
					hping3 -S -p $port -c 1 $host 2> /dev/null
				done
					echo "SCAN FINISH!"
	fi
elif [ $choice == "3" ]
then
	read -p "INSERT THE TARGET EX: 192.157.1 : " main
	read -p "INSERT INITAL : " init
	read -p "INSERT FINAL : " final
	read -p "INSERT PORT TO SCAN (0->65535) : "  port

	if [ $main == "" -o $init == "" -o $final == "" -o $port == "" ] || [ $port -le -1 -o $port -gt 65535 ]
		then 
		echo "INVALID PARAMS"
		else
		echo "INIT SCAN PORT: $port IN HOSTS!"
			for host in `seq $init $final`
				do
					hping3 -S -p $port -c 1 $main.$host 2> /dev/null
				done
					echo "SCAN FINISH!"
	fi
fi









