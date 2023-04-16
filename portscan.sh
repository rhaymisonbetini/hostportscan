#!/usr/bin/env bash
clear
RED='\033[0;31m'
NC='\033[0m'
BBlue='\033[1;34m'
if [[ ${1} == "--help" ]]; then
	printf "
			${RED}THIS PROJECT WAS DEVELOPED TO SCAN HOST PORTS TO DISCOVER POSSIBLE TARGETS.\n\
			1 - PERFORMS A SCAN ON ALL HOSTS PASSED ON PORT 80.\n
			2 - PERFORMS A SCAN IN POSSIBLE PORTS IN A HOST. \n
			3 - PERFORMS A SPECIFIC SCAN ON A PORT IN SEVERAL HOST. \n
			4 - PERFORM A TRACE HOST TO THE TARGET THROUGH IPV4 OR IPV6.\n${NC}"
else
	source ./func.sh
	while [[ 1 > 0 ]]; do
		printf "${RED} 
 _     _  _____    _    _______    ______   _____  ______  _______       _     ______        ______  
| |   | |/ ___ \  | |  (_______)  (_____ \ / ___ \(_____ \(_______)     | |   / _____)  /\  |  ___ \ 
| |__ | | |   | |  \ \  _          _____) ) |   | |_____) )_             \ \ | /       /  \ | |   | |
|  __)| | |   | |   \ \| |        |  ____/| |   | (_____ (| |             \ \| |      / /\ \| |   | |
| |   | | |___| |____) ) |_____   | |     | |___| |     | | |_____    _____) ) \_____| |__| | |   | |
|_|   |_|\_____(______/ \______)  |_|      \_____/      |_|\______)  (______/ \______)______|_|   |_|
  	${NC} \n"

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

		case $choice in
		1) avalible_host ;;
		2) avalibe_ports_in_host ;;
		3) avalibe_port_in_hosts ;;
		4) traceroute ;;
		5) subdomains ;;
		exit) exit ;;
		*) echo "INVALID OPTION!" ;;
		esac
		sleep 4
	done
fi
