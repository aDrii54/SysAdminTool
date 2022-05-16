#!/bin/bash
# 23/04/2022
# "Configure private IPv4" - "Network Options" - SysAdminTool 1.0

#creamos fichero ipinfo.log exportando contenido de "ip a"
ip a > tmp/ipinfo.log

#variables
bold=$(tput bold)
normal=$(tput sgr0)
subrayado=$(tput smul)
rojo=$(tput setaf 1)


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


#crear fichero yaml dependiendo de las tarjetas de red del sistema
if [ $count2 -gt 0 ]; then
	ls /etc/netplan/00-installer-config.yaml
	ls /etc/netplan/00-installer-config-dhcp.yaml
	valor=$?
	if [ $valor -eq 2 ]; then
	touch /etc/netplan/00-installer-config.yaml
	touch /etc/netplan/00-installer-config-dhcp.yaml
	echo "network:" > /etc/netplan/00-installer-config.yaml
 	echo "  version: 2" >> /etc/netplan/00-installer-config.yaml
 	echo "network:" > /etc/netplan/00-installer-config-dhcp.yaml
 	echo "  version: 2" >> /etc/netplan/00-installer-config-dhcp.yaml
 	else
 		echo 2>/dev/null
 	fi
else
	echo 2>/dev/null
fi

if [ $count3 -gt 0 ]; then
	ls /etc/netplan/01-installer-config.yaml
	ls /etc/netplan/01-installer-config-dhcp.yaml
	valor=$?
	if [ $valor -eq 2 ]; then
	touch /etc/netplan/01-installer-config.yaml
	touch /etc/netplan/01-installer-config-dhcp.yaml
	echo "network:" > /etc/netplan/01-installer-config.yaml
 	echo "  version: 2" >> /etc/netplan/01-installer-config.yaml
 	echo "network:" > /etc/netplan/01-installer-config-dhcp.yaml
 	echo "  version: 2" >> /etc/netplan/01-installer-config-dhcp.yaml
 	else
 		echo 2>/dev/null
 	fi
else
	echo 2>/dev/null
fi

if [ $count4 -gt 0 ]; then
	ls /etc/netplan/02-installer-config.yaml
	ls /etc/netplan/02-installer-config-dhcp.yaml
	valor=$?
	if [ $valor -eq 2 ]; then
	touch /etc/netplan/02-installer-config.yaml
	touch /etc/netplan/02-installer-config-dhcp.yaml
	echo "network:" > /etc/netplan/02-installer-config.yaml
 	echo "  version: 2" >> /etc/netplan/02-installer-config.yaml
 	echo "network:" > /etc/netplan/02-installer-config-dhcp.yaml
 	echo "  version: 2" >> /etc/netplan/02-installer-config-dhcp.yaml
 	else
 		echo 2>/dev/null
 	fi
else
	echo 2>/dev/null
fi

if [ $count5 -gt 0 ]; then
	ls /etc/netplan/03-installer-config.yaml
	ls /etc/netplan/03-installer-config-dhcp.yaml
	valor=$?
	if [ $valor -eq 2 ]; then
	touch /etc/netplan/03-installer-config.yaml
	touch /etc/netplan/03-installer-config-dhcp.yaml
	echo "network:" > /etc/netplan/03-installer-config.yaml
 	echo "  version: 2" >> /etc/netplan/03-installer-config.yaml
 	echo "network:" > /etc/netplan/03-installer-config-dhcp.yaml
 	echo "  version: 2" >> /etc/netplan/03-installer-config-dhcp.yaml
 	else
 		echo 2>/dev/null
 	fi
else
	echo 2>/dev/null
fi

ip a show $netcard1 | grep "inet " | cut -d ' ' -f6,11 | sed -e 's/noprefixroute/estática/g' | sed -e 's/dynamic/dinámica/g' | sed -e 's/secondary/estática secundaria/g' | sed -e 's/lo/estática/g' > tmp/addrlines1.log
ip a show $netcard2 | grep "inet " | cut -d ' ' -f6,11 | sed -e 's/noprefixroute/estática/g' | sed -e 's/dynamic/dinámica/g' | sed -e 's/secondary/estática secundaria/g' | sed -e 's/enp0s3/estática/g' > tmp/addrlines2.log
ip a show $netcard3 | grep "inet " | cut -d ' ' -f6,11 | sed -e 's/noprefixroute/estática/g' | sed -e 's/dynamic/dinámica/g' | sed -e 's/secondary/estática secundaria/g' | sed -e 's/enp0s8/estática/g' > tmp/addrlines3.log
ip a show $netcard4 | grep "inet " | cut -d ' ' -f6,11 | sed -e 's/noprefixroute/estática/g' | sed -e 's/dynamic/dinámica/g' | sed -e 's/secondary/estática secundaria/g' | sed -e 's/enp0s9/estática/g' > tmp/addrlines4.log
ip a show $netcard5 | grep "inet " | cut -d ' ' -f6,11 | sed -e 's/noprefixroute/estática/g' | sed -e 's/dynamic/dinámica/g' | sed -e 's/secondary/estática secundaria/g' | sed -e 's/enp0s10/estática/g'> tmp/addrlines5.log

#direcciones de las tarjetas de red
addrsnetcard1=$(ip a show $netcard1 | grep "inet " | cut -d ' ' -f6 | for i in `< tmp/addrlines1.log`; do echo -n ${i}" ";done; echo "")
addrsnetcard2=$(ip a show $netcard2 | grep "inet " | cut -d ' ' -f6 | for i in `< tmp/addrlines2.log`; do echo -n ${i}" ";done; echo "")
addrsnetcard3=$(ip a show $netcard3 | grep "inet " | cut -d ' ' -f6 | for i in `< tmp/addrlines3.log`; do echo -n ${i}" ";done; echo "")
addrsnetcard4=$(ip a show $netcard4 | grep "inet " | cut -d ' ' -f6 | for i in `< tmp/addrlines4.log`; do echo -n ${i}" ";done; echo "")
addrsnetcard5=$(ip a show $netcard5 | grep "inet " | cut -d ' ' -f6 | for i in `< tmp/addrlines5.log`; do echo -n ${i}" ";done; echo "")



cat /etc/netplan/00-installer-config.yaml | grep "gateway4: "  | cut -d ':' -f2 > tmp/gatewaync2.log
cat /etc/netplan/01-installer-config.yaml | grep "gateway4: "  | cut -d ':' -f2 > tmp/gatewaync3.log
cat /etc/netplan/02-installer-config.yaml | grep "gateway4: "  | cut -d ':' -f2 > tmp/gatewaync4.log
cat /etc/netplan/03-installer-config.yaml | grep "gateway4: "  | cut -d ':' -f2 > tmp/gatewaync5.log


#puerta de enlace de las tarjetas de red
gatewaynetcard2=$(cat /etc/netplan/00-installer-config.yaml | grep "gateway4: "  | cut -d ':' -f2 | for i in `< tmp/gatewaync2.log`; do echo -n ${i}"                       ";done; echo "")
gatewaynetcard3=$(cat /etc/netplan/01-installer-config.yaml | grep "gateway4: "  | cut -d ':' -f2 | for i in `< tmp/gatewaync3.log`; do echo -n ${i}"                       ";done; echo "")
gatewaynetcard4=$(cat /etc/netplan/02-installer-config.yaml | grep "gateway4: "  | cut -d ':' -f2 | for i in `< tmp/gatewaync4.log`; do echo -n ${i}"                       ";done; echo "")


#servidores DNS de las tarjetas de red
dnsnetcard2=$(cat /etc/netplan/00-installer-config.yaml | grep -Pzo '\s{7}nameservers:[^\n]*\n\K[^\n]+' | cut -d ':' -f2,3,4,5,6 | tr 'addresses:' ' ')
dnsnetcard3=$(cat /etc/netplan/01-installer-config.yaml | grep -Pzo '\s{7}nameservers:[^\n]*\n\K[^\n]+' | cut -d ':' -f2,3,4,5,6 | tr 'addresses:' ' ')
dnsnetcard4=$(cat /etc/netplan/02-installer-config.yaml | grep -Pzo '\s{7}nameservers:[^\n]*\n\K[^\n]+' | cut -d ':' -f2,3,4,5,6 | tr 'addresses:' ' ')
dnsnetcard5=$(cat /etc/netplan/03-installer-config.yaml | grep -Pzo '\s{7}nameservers:[^\n]*\n\K[^\n]+' | cut -d ':' -f2,3,4,5,6 | tr 'addresses:' ' ')


#puertas de enlace dinámicas y estáticas
gatewaydinamic2=$(ip r | grep $netcard2 | grep "default via" | cut -c 13-24)
gatewaydinamic3=$(ip r | grep $netcard3 | grep "default via" | cut -c 13-24)
gatewaydinamic4=$(ip r | grep $netcard4 | grep "default via" | cut -c 13-24)
gatewaydinamic5=$(ip r | grep $netcard5 | grep "default via" | cut -c 13-24)


tput clear


############################################
#		                                   #
#	           MENÚ PRINCIPAL              #
#				                           #
############################################

#Poner color de fondo + valor 3=orange
tput setab 4
tput bold

echo -e "                      C O N F I G U R A R - T A R J E T A S - D E - R E D                           \n"

#Restaurar valores por defecto
tput sgr0

#mostramos las diferentes tarjetas de red conectadas al equipo. "count" devuelve 1 si existe y 0 si no.
echo -e " \n`tput setaf 3` TARJETAS DE RED\n`tput sgr0`"
		if [ $netcard2 ]; then
				if [ -n "${addrsnetcard2}" ]; then
						echo " ${bold}$netcard2${normal} -> `tput setaf 2`$addrsnetcard2${normal}"	
				else 
					echo -e " ${bold}$netcard2${normal} -> ${rojo}No tiene dirección IPv4 configurada o la interfaz está desactivada${normal}"
				fi
		elif [ -z $netcard2 ]; then
					echo -e ""
		fi

		if [ $netcard3 ]; then
				if [ -n "${addrsnetcard3}" ]; then
						echo " ${bold}$netcard3${normal} -> `tput setaf 2`$addrsnetcard3${normal}"	
				else 
					echo -e " ${bold}$netcard3${normal} -> ${rojo}No tiene dirección IPv4 configurada o la interfaz está desactivada${normal}"
				fi
		elif [ -z $netcard3 ]; then
					echo -e ""
		fi
	

		if [ $netcard4 ]; then
				if [ -n "${addrsnetcard4}" ]; then
						echo " ${bold}$netcard4${normal} -> `tput setaf 2`$addrsnetcard4${normal}"	
				else 
					echo -e " ${bold}$netcard4${normal} -> ${rojo}No tiene dirección IPv4 configurada o la interfaz está desactivada${normal}"
				fi
		elif [ -z $netcard4 ]; then
					echo -e ""
		fi
	
		if [ $netcard5 ]; then
				if [ -n "${addrsnetcard5}" ]; then
						echo " ${bold}$netcard5${normal} -> `tput setaf 2`$addrsnetcard5${normal}"	
				else 
					echo -e " ${bold}$netcard5${normal} -> ${rojo}No tiene dirección IPv4 configurada o la interfaz está desactivada${normal}"
				fi
		elif [ -z $netcard5 ]; then
					echo -e ""
		fi

echo -e "`tput sgr0``tput bold`____________________________________________________________________________________________________`tput sgr0``tput setaf 2`\n"

if [ $netcard2 ]; then
echo -e "`tput sgr0``tput setaf 3`[ 1 ] CONFIGURAR TARJETA DE RED `tput setaf 7`$netcard2"${normal}
fi
if [ $netcard3 ]; then
echo -e "`tput sgr0``tput setaf 3`[ 2 ] CONFIGURAR TARJETA DE RED `tput setaf 7`$netcard3"${normal}
fi
if [ $netcard4 ]; then
echo -e "`tput sgr0``tput setaf 3`[ 3 ] CONFIGURAR TARJETA DE RED `tput setaf 7`$netcard4"${normal}
fi
if [ $netcard5 ]; then
echo -e "`tput sgr0``tput setaf 3`[ 4 ] CONFIGURAR TARJETA DE RED `tput setaf 7`$netcard5"${normal}
fi

tput sgr0

echo -e "\n\n\e[1;30m[ 0 ] Salir de SysAdminTool\e[0m"
echo -e "\e[1;30m[ 9 ] Retroceder una página\e[0m"

echo -e "`tput sgr0``tput bold`____________________________________________________________________________________________________`tput sgr0`\n\n"

#Opciones de red

read -p "Elige una opción: "  choice5

case $choice5 in
1)

	. ./red/tarjeta1.sh
	
#configurar tarjeta netcard3
;;
2)
	. ./red/tarjeta2.sh
;;
3)
	. ./red/tarjeta3.sh							
;;
4)
	. ./red/tarjeta4.sh
;;
0)
	clear
	echo -e "\n ¡Gracias por usar `tput setaf 5``tput bold`SysAdminTool`tput sgr0`!\n"
	exit 0
;;
9)
	. ./red/menured.sh
;;
*)
	. ./red/menured.sh
;;

esac

