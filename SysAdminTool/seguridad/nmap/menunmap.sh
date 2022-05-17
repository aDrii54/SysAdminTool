#!/bin/bash
# 11/05/2022
# "Scan" - "Network Options" - SysAdminTool 1.0

ls /usr/bin/nmap 2>/dev/null
valor=$(echo $?)

clear

if [ $valor -eq 2 ]; then
	read -p "Es necesario instalar la herramienta NMAP ¿quiere continuar? (s/n): " choice13
	case $choice13 in
		s)
			sudo apt install nmap -y
		;;
		*)
			. mainmenu.sh
		;;
	esac
elif [ $valor -eq 0 ]; then

	echo "1. Escanear los equipos despiertos de la red LAN."
	


	read -p "Elige una opción: " choice14
	case $choice14 in
		1)


			. escanearequiposdespiertos.sh
	;;
		2)
	;;
	esac

fi