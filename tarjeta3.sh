#!/bin/bash
# 23/04/2022
# "Configure private IPv4" - "Network Options" - SysAdminTool 1.0
#creamos fichero ipinfo.log exportando contenido de "ip a"

#variables
bold=$(tput bold)
normal=$(tput sgr0)
subrayado=$(tput smul)
rojo=$(tput setaf 1)


#tantas netcard como posibles tarjetas de red tenga el usuario
netcard1=$(grep ^1  tmp/ipinfo.log | cut -d ' ' -f 2 | tr ':' ' ')
netcard2=$(grep ^2  tmp/ipinfo.log | cut -d ' ' -f 2 | tr ':' ' ')
netcard4=$(grep ^3  tmp/ipinfo.log | cut -d ' ' -f 2 | tr ':' ' ')
netcard4=$(grep ^4  tmp/ipinfo.log | cut -d ' ' -f 2 | tr ':' ' ')
netcard5=$(grep ^5  tmp/ipinfo.log | cut -d ' ' -f 2 | tr ':' ' ')

#el contador saca 1 si existe la tarjeta de red y 0 si no existe
count1=$(grep ^1  tmp/ipinfo.log | wc -l)
count2=$(grep ^2  tmp/ipinfo.log | wc -l)
count3=$(grep ^3  tmp/ipinfo.log | wc -l)
count4=$(grep ^4  tmp/ipinfo.log | wc -l)
count5=$(grep ^5  tmp/ipinfo.log | wc -l)

ip a show $netcard1 | grep "inet " | cut -d ' ' -f6,11 | sed -e 's/noprefixroute/estática/g' | sed -e 's/dynamic/dinámica/g' | sed -e 's/secondary/estática secundaria/g' | sed -e 's/lo/estática/g' > tmp/addrlines1.log
ip a show $netcard2 | grep "inet " | cut -d ' ' -f6,11 | sed -e 's/noprefixroute/estática/g' | sed -e 's/dynamic/dinámica/g' | sed -e 's/secondary/estática secundaria/g' | sed -e 's/enp0s3/estática/g' > tmp/addrlines2.log
ip a show $netcard3 | grep "inet " | cut -d ' ' -f6,11 | sed -e 's/noprefixroute/estática/g' | sed -e 's/dynamic/dinámica/g' | sed -e 's/secondary/estática secundaria/g' | sed -e 's/enp0s8/estática/g' > tmp/addrlines3.log
ip a show $netcard4 | grep "inet " | cut -d ' ' -f6,11 | sed -e 's/noprefixroute/estática/g' | sed -e 's/dynamic/dinámica/g' | sed -e 's/secondary/estática secundaria/g' | sed -e 's/enp0s9/estática/g' > tmp/addrlines4.log
ip a show $netcard5 | grep "inet " | cut -d ' ' -f6,11 | sed -e 's/noprefixroute/estática/g' | sed -e 's/dynamic/dinámica/g' | sed -e 's/secondary/estática secundaria/g' | sed -e 's/enp0s10/estática/g'> tmp/addrlines5.log

#direcciones de las tarjetas de red
addrsnetcard1=$(ip a show $netcard1 | grep "inet " | cut -d ' ' -f6 | for i in `< tmp/addrlines1.log`; do echo -n ${i}" ";done; echo "")
addrsnetcard2=$(ip a show $netcard2 | grep "inet " | cut -d ' ' -f6 | for i in `< tmp/addrlines2.log`; do echo -n ${i}" ";done; echo "")
addrsnetcard4=$(ip a show $netcard3 | grep "inet " | cut -d ' ' -f6 | for i in `< tmp/addrlines3.log`; do echo -n ${i}" ";done; echo "")
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
gatewaynetcard=$(cat /etc/netplan/03-installer-config.yaml | grep "gateway4: "  | cut -d ':' -f2 | for i in `< tmp/gatewaync4.log`; do echo -n ${i}"                       ";done; echo "")

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

echo -e "                             C O N F I G U R A R - T A R J E T A - 1                                \n"

tput sgr0
echo -e "\n ${bold}`tput setab 4` $netcard4${normal}"
echo -e "\n ${bold}DIRECCIÓN IPv4:${normal} `tput setaf 2`$addrsnetcard4${normal}"
echo -e " ${bold}PUERTA DE ENLACE:${normal} `tput setaf 2`$gatewaydinamic4${normal}"
if [ $dnsnetcard4 ]; then
echo -e " ${bold}SERVIDORES DNS:${normal} `tput setaf 2`$dnsnetcard4${normal}\n"
fi
echo -e "`tput sgr0``tput bold`____________________________________________________________________________________________________`tput sgr0``tput setaf 2`\n"

echo -e "`tput sgr0``tput setaf 3`[ 1 ] CAMBIAR DIRECCIÓN IPv4"
echo -e "`tput sgr0``tput setaf 3`[ 2 ] CAMBIAR DIRECCIÓN DNS `tput setaf 1`(SOLO EN ESTÁTICA)${normal}"
echo -e "`tput sgr0``tput setaf 3`[ 3 ] ACTIVAR/DESACTIVAR TARJETA DE RED"
tput sgr0
echo -e "\n\n\e[1;30m[ 0 ] Salir de SysAdminTool\e[0m"
echo -e "\e[1;30m[ 9 ] Retroceder una página\e[0m"

echo -e "`tput sgr0``tput bold`____________________________________________________________________________________________________`tput sgr0`\n\n"

read -p "Elige una opción: " choice8
	case $choice8 in
    1)
		echo -e "\n"
		read -p "¿Quieres configurar una direccion ip estática`tput setaf 2`(e)${normal} o dinámica`tput setaf 3`(d)${normal}?: " choice9
			case $choice9 in
			e)

				numerodelineas=$(cat /etc/netplan/02-installer-config.yaml | wc -l)

				if [ $numerodelineas -lt 5 ]; then

					#primero borramos el contenido del fichero dhcp.yaml
						echo "network:" > /etc/netplan/02-installer-config-dhcp.yaml
							echo "  version: 2" >> /etc/netplan/02-installer-config-dhcp.yaml

							#luego añadimos la información de nuestra dirección estática al all.yaml
							echo -e "\n"
						read -p "Escribe la dirección Ipv4 y su máscara de subred (p. ej. 192.168.1.36/24): " ipv4
						read -p "Escribe la puerta de enlace (gateway): " gt
						read -p "Escribe la dirección DNS (p. ej. 8.8.8.8 sin corchetes): " dns
						echo "network:" > /etc/netplan/02-installer-config.yaml
							echo "  version: 2" >> /etc/netplan/02-installer-config.yaml
						echo "  ethernets:" >> /etc/netplan/02-installer-config.yaml
						echo "    $netcard4:" >> /etc/netplan/02-installer-config.yaml
						echo "      addresses: [$ipv4]" >> /etc/netplan/02-installer-config.yaml
						echo "      gateway4: $gt" >> /etc/netplan/02-installer-config.yaml
						echo "      nameservers:" >> /etc/netplan/02-installer-config.yaml
						echo "         addresses: [$dns]" >> /etc/netplan/02-installer-config.yaml
						netplan apply
						echo -e "\n"
						echo -e "`tput setaf 2`Ha añadido la dirección $ipv4 a la tarjeta de red $netcard4${normal}"
						echo -e "\n"
						read -p "Pulse cualquier tecla para continuar"
						echo -e "\n`tput setaf 2`APLICANDO CONFIGURACIÓN...`tput sgr0`"
							sleep 2
						. ./red/configurarip.sh

				elif [ $numerodelineas -gt 5 ]; then
					echo -e ""
					read -p "Ya existe una dirección ip configurada para $netcard4, ¿quiere modificar esta dirección? (s/n): " eleccion
				fi

				if [ $eleccion == "s" ]; then
						read -p "Escribe la dirección ip existente y su máscara de subred (p. ej. 192.168.1.36/24): " ipv4exist
						read -p "Escribe la nueva dirección ip con su máscara: " ipv4noexist
						sed -i "s:$ipv4exist:$ipv4noexist:g" /etc/netplan/02-installer-config.yaml
						echo -e "`tput setaf 2`\nHas cambiado la dirección IP $ipv4exist por $ipv4noexist\n${normal}"
						netplan apply
						read -p "Pulse cualquier tecla para continuar"
						. ./red/configurarip.sh
				elif [ $eleccion == "n" ]; then

						. ./red/tarjeta3.sh

				else
					read -p "Pulse cualquier tecla para continuar"
					. ./red/tarjeta3.sh
				fi


			;;
			d)
				echo -e "${subrayado}\nSi configura la ip dinámica perderá todas las ip estáticas configuradas${normal}\n"
				read -p "¿Quieres continuar? [s/n]: " choice11
				case $choice11 in
					s)
						#primero borramos todas las ip estáticas del fichero all.yaml
						echo "network:" > /etc/netplan/02-installer-config.yaml
							echo "  version: 2" >> /etc/netplan/02-installer-config.yaml

							#después añadimos la información dinámica al fichero dhcp.yaml
						echo "network:" > /etc/netplan/02-installer-config-dhcp.yaml
							echo "  version: 2" >> /etc/netplan/02-installer-config-dhcp.yaml
							echo "  ethernets:" >> /etc/netplan/02-installer-config-dhcp.yaml
						echo "    $netcard4:" >> /etc/netplan/02-installer-config-dhcp.yaml
						echo "       dhcp4: yes" >> /etc/netplan/02-installer-config-dhcp.yaml
							netplan apply
							echo -e "\nHa configurado la IP de manera dinámica para $netcard4\n"
							read -p "Pulse cualquier boton para continuar"
							echo -e "\n`tput setaf 2`APLICANDO CONFIGURACIÓN...`tput sgr0`"
							sleep 2
							. ./red/configurarip.sh
						;;
						n)
							. ./red/configurarip.sh

					;;
					*)
						. ./red/tarjeta3.sh
				;;
				esac	
			;;
			esac		
	;;
	2)
		if [ -n "${dnsnetcard4}" ]; then
		echo -e "\nTu dirección DNS es $dnsnetcard4\n"
		read -p "Escribe la nueva dirección DNS (sin corchetes): " dnsnew		
		sed -i "8 s/\[\([^]]*\)\]/\[$dnsnew]/g" /etc/netplan/02-installer-config.yaml
		echo "Ha cambiado la dirección $dnsnetcard4 por la dirección [$dnsnew]"
		else
			echo -e "\n\n`tput sgr0`               `tput bold``tput setab 1``tput sgr0``tput setab 1``tput setaf 0` NO SE PUEDE CAMBIAR LA DIRECCIÓN DNS CON IPv4 DINÁMICA CONFIGURADA `tput sgr0`\n\n\n\n\n\n"
        read -p "                                   Pulse `tput setaf 3`ENTER`tput sgr0` para continuar`tput setaf 0``tput sgr0`"
			tput sgr0
			clear
			tput sgr0
			. ./red/tarjeta3.sh
		fi

	
	;;	
	3)
		echo -e "\n"
		read -p "¿Quieres activar(1) o desactivar(2) la tarjeta de red $netcard4?: " choice12
			case $choice12 in
				1)
					ip link set $netcard4 up  
					echo -e "\nLa tarjeta $netcard4 está activada\n"
					read -p "Pulse cualquier botón para continuar"
					. ./red/menured.sh
				;;
				2)
					ip link set $netcard4 down
					echo -e "\nLa tarjeta $netcard4 está desactivada\n"
					read -p "Pulse cualquier botón para continuar"
					. ./red/menured.sh
				;;
				esac
	;;
	4)
		. menuprincipal.sh
	;;
	esac