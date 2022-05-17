#!/bin/bash
# 13/05/2022
# "Escanear equipos despiertos" - "nmap" - "Network Options" - SysAdminTool 1.0

#creamos fichero ipinfo.log exportando contenido de "ip a"
ip a > tmp/ipinfo.log

#tantas netcard como posibles tarjetas de red tenga el usuario
netcard1=$(grep ^1  tmp/ipinfo.log | cut -d ' ' -f 2 | tr ':' ' ')
netcard2=$(grep ^2  tmp/ipinfo.log | cut -d ' ' -f 2 | tr ':' ' ')
netcard3=$(grep ^3  tmp/ipinfo.log | cut -d ' ' -f 2 | tr ':' ' ')
netcard4=$(grep ^4  tmp/ipinfo.log | cut -d ' ' -f 2 | tr ':' ' ')
netcard5=$(grep ^5  tmp/ipinfo.log | cut -d ' ' -f 2 | tr ':' ' ')

#el contador saca 1 si existe la tarjeta de red y 0 si no existe
count1=$(grep ^1  tmp/ipinfo.log | wc -l)
count2=$(grep ^2  tmp/ipinfo.log | wc -l)
count3=$(grep ^3  tmp/ipinfo.log | wc -l)
count4=$(grep ^4  tmp/ipinfo.log | wc -l)
count5=$(grep ^5  tmp/ipinfo.log | wc -l)

#para sacar dirección de red de cada tarjeta
rednetcard2=$(ip route | awk NR==3{'print $1'})
rednetcard3=$(ip route | awk NR==4{'print $1'})
rednetcard4=$(ip route | awk NR==5{'print $1'})
rednetcard5=$(ip route | awk NR==6{'print $1'})

echo -e "\n¿Con que tarjeta quieres escanear la red LAN?"

if [ $netcard2 ]; then
	
			echo "1. $netcard2"
fi

if [ $netcard3 ]; then
	
			echo "2. $netcard3"
fi

if [ $netcard4 ]; then
	
			echo "3. $netcard4"
fi

if [ $netcard5 ]; then
	
			echo "4. $netcard5"
fi

read -p "Elige un número: " choice15

case $choice15 in
	1)
		if [ $count2 -eq 1 ]; then
			echo -e "\nEscanenado dirección de red $rednetcard2"
			nmap -sP $rednetcard2 > /media/sf_Script_ubuntu_server/NUEVOS/tmp/equiposup.log
			#el awk de esta linea hace que no se muestren las lineas que contengan la palabra "host", no nos interesan esas lineas
			cat /media/sf_Script_ubuntu_server/NUEVOS/tmp/equiposup.log | awk '$0 !~ /Host/'




		else 
			echo "no tienes tarjeta número 1"

		fi
;;
	2)
		if [ $count3 -eq 1 ]; then
			echo "escanenado con ip de la red de tarjeta $netcard3"

		else 
			echo "no tienes tarjeta número 2"

		fi
;;
	3)
		if [ $count4 -eq 1 ]; then
			echo "escanenado con ip de la red de tarjeta $netcard4"

		else 
			echo "no tienes tarjeta número 3"

		fi
;;
esac
