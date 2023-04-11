#!/usr/bin/env bash

RED='\033[0;31m'
NC='\033[0m'
BBlue='\033[1;34m'

if [[ ${1} == "--help" ]]
then
 		printf "
			${RED}THIS PROJECT WAS DEVELOPED TO SCAN HOST PORTS TO DISCOVER POSSIBLE TARGETS.\n\
			1 - PERFORMS A SCAN ON ALL HOSTS PASSED ON PORT 80.\n
			2 - PERFORMS A SCAN IN POSSIBLE PORTS IN A HOST. \n
			3 - PERFORMS A SPECIFIC SCAN ON A PORT IN SEVERAL HOST. \n
			4 - PERFORM A TRACE HOST TO THE TARGET THROUGH IPV4 OR IPV6.\n${NC}"
else

printf "${RED} _     _  _____    _    _______    ______   _____  ______  _______       _     ______        ______  
| |   | |/ ___ \  | |  (_______)  (_____ \ / ___ \(_____ \(_______)     | |   / _____)  /\  |  ___ \ 
| |__ | | |   | |  \ \  _          _____) ) |   | |_____) )_             \ \ | /       /  \ | |   | |
|  __)| | |   | |   \ \| |        |  ____/| |   | (_____ (| |             \ \| |      / /\ \| |   | |
| |   | | |___| |____) ) |_____   | |     | |___| |     | | |_____    _____) ) \_____| |__| | |   | |
|_|   |_|\_____(______/ \______)  |_|      \_____/      |_|\______)  (______/ \______)______|_|   |_|${NC} \n\n\n"

printf "${BBlue}##################################################################
#Script Name	: portscan.sh
#Description	: Project to scan host and ports
#Author       	: r betini
#Email         	: rhaymisoncristian@gmail.com
################################################################### \n\n"

echo "SELECT YOU SCAN CHOICE"
echo "---------------------------------"
echo "[1] - Scan avalible host - default port 80"
echo "[2] - Scan avalibles ports in host"
echo "[3] - Scan avalible port in hosts" 
echo "[4] - Trace route to target "
echo "[5] - Scan subdomains in target"
read -p "SELECT: " choice

if [ $choice == "1" ]
then
	read -p "INSERT TARGET EX:192.168.1 - " main
	read -p "INSERT INITAL: " init
	read -p "INSERT LIMIT: "  final

	if [ $init -ge 1 -a $final -le 254  -a main != "" ]
		then
			echo "SCAN INIT"
			for host in `seq $init $final`
				do
					hping3 -S -p 80 -c 1 $main.$host 1>> "./${main}-${init}-${final}.txt" 2> /dev/null | grep "flags=SA"
				done
					echo "SCAN FINISH!" 
		else
			echo "INVALID VALUES FOR INTERVAL"
	fi

elif [ $choice == "2" ]
then
	read -p "INSERT THE TARGET EX: 192.157.1.30 - " host
	read -p "INSERT INITAL PORT : " init
	read -p "INSERT FINAL  PORT : " final

	if [ $init -le -1 -o $init  -gt 65535 -o $init == "" ] || [ $final -le -1 -o $final -gt 65535 -o $final == "" ]
		then
		echo "PORT INTERVAL BETWEEN 0 AND 65535"
		else
		echo "INIT SCAN BY PORTS IN HOST: $host"
			for port in `seq $init $final`
				do
					hping3 -S -p $port -c 1 $host 1>> "./${host}-${init}-${final}.txt" 2> /dev/null | grep "flags=SA"
				done
					echo "SCAN FINISH!"
	fi
elif [ $choice == "3" ]
then
	read -p "INSERT THE TARGET EX: 192.157.1 - " main
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
					hping3 -S -p $port -c 1 $main.$host 1> "./${main}-${init}-${final}.txt" 2> /dev/null | grep "flags=SA"
				done
					echo "SCAN FINISH!"
	fi

elif [ $choice == "4" ]
then

	read -p "INSERT THE TARGET EX: 192.157.1.30 - " host
	read -p "TIPE OF IP TRACER (IPV4 OR IPV6): OPS: [4,6] :" ip
	if [ $host != "" ]
		then
			echo "MAKE TRACEROUTER"
			traceroute -n "-${ip}"  $host >> "tracerouter-${host}.txt"
		else
			echo "INVALID TARGET"
	fi

elif [ $choice == "5" ]
	then
	read -p "INSERT THE TARGET EX: 192.168.157.2 - " host
		sudo rm -rf index.html subs.txt
		wget $host
		cat index.html | egrep -i "href|http|https" | cut -d "/" -f3 | sed 's/"/ /' | sed 's/crossorigin="crossorigin"/ /' | sed 's/>/ /' |grep -v "window.location.href" | egrep -i ".com|.io"  | sort -u > subs.txt
			for host in `cat subs.txt `
				do
					host $host | grep "has address"
				done
	else
		echo "INVALID DOMAIN"

fi
fi







