#!/bin/bash
# 22/04/2022
# "Show private IP" - "Network Options" - SysAdminTool 1.0

#creamos fichero ipinfo.log exportando contenido de "ip a"
mkdir tmp
ip a > tmp/ipinfo.log

#variables
bold=$(tput bold)
normal=$(tput sgr0)

#tantas netcard como posibles tarjetas de red tenga el usuario
#devolverá lo por defecto
netcard1=$(grep ^1  tmp/ipinfo.log | cut -d ' ' -f 2 | tr ':' ' ')
#devolverá enp0s3 por defecto
netcard2=$(grep ^2  tmp/ipinfo.log | cut -d ' ' -f 2 | tr ':' ' ')
#y así el resto
netcard3=$(grep ^3  tmp/ipinfo.log | cut -d ' ' -f 2 | tr ':' ' ')
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
addrsnetcard3=$(ip a show $netcard3 | grep "inet " | cut -d ' ' -f6 | for i in `< tmp/addrlines3.log`; do echo -n ${i}" ";done; echo "")
addrsnetcard4=$(ip a show $netcard4 | grep "inet " | cut -d ' ' -f6 | for i in `< tmp/addrlines4.log`; do echo -n ${i}" ";done; echo "")
addrsnetcard5=$(ip a show $netcard5 | grep "inet " | cut -d ' ' -f6 | for i in `< tmp/addrlines5.log`; do echo -n ${i}" ";done; echo "")


#limpiar la pantalla

tput clear


############################################
#		                                   #
#	           MENÚ PRINCIPAL              #
#				                           #
############################################

#Poner color de fondo + valor 3=orange
tput setab 4
tput bold

echo -e "                                             V E R - I P                                            \n"
 
#Restaurar valores por defecto
tput sgr0

#mostramos las diferentes tarjetas de red conectadas al equipo. "count" devuelve 1 si existe y 0 si no.
echo -e " \n`tput setaf 3`TARJETAS DE RED`tput sgr0`\n"

if [ $netcard1 ]; then
				if [ -n "${addrsnetcard1}" ]; then
						echo " ${bold}$netcard1${normal}-> $addrsnetcard1${normal}"	
#si existe pero no tiene direccion ip, lo muestra por pantalla y pregunta si quiere configurarla.
				else 
					echo -e ${bold}" $netcard1${normal} --> \e[1;31mNo tiene dirección IPv4 configurada o la interface está desactivada\e[0m"
				fi
		elif [ -z $netcard1 ]; then
					echo ""
fi

if [ $netcard2 ]; then
				if [ -n "${addrsnetcard2}" ]; then
						echo " ${bold}$netcard2${normal}-> `tput setaf 2`$addrsnetcard2${normal}"	
#si existe pero no tiene direccion ip, lo muestra por pantalla y pregunta si quiere configurarla.
				else 
					echo -e " ${bold}$netcard2${normal} --> \e[1;31mNo tiene dirección IPv4 configurada o la interface está desactivada\e[0m"
				fi
		elif [ -z $netcard2 ]; then
					echo ""
fi

if [ $netcard3 ]; then
				if [ -n "${addrsnetcard3}" ]; then
						echo " ${bold}$netcard3${normal}-> `tput setaf 2`$addrsnetcard3${normal}"
#si existe pero no tiene direccion ip, lo muestra por pantalla y pregunta si quiere configurarla.
				else 
					echo -e " ${bold}$netcard3${normal} --> \e[1;31mNo tiene dirección IPv4 configurada o la interface está desactivada\e[0m"
				fi
		elif [ -z $netcard3 ]; then
					echo ""
fi

if [ $netcard4 ]; then
				if [ -n "${addrsnetcard4}" ]; then
						echo " ${bold}$netcard4${normal}-> `tput setaf 2`$addrsnetcard4${normal}"
#si existe pero no tiene direccion ip, lo muestra por pantalla y pregunta si quiere configurarla.
				else 
					echo -e " ${bold}$netcard4${normal} --> \e[1;31mNo tiene dirección IPv4 configurada o la interface está desactivada\e[0m"
				fi
		elif [ -z $netcard4 ]; then
					echo ""
fi

if [ $netcard5 ]; then
				if [ -n "${addrsnetcard5}" ]; then
						echo " ${bold}$netcard5${normal}-> `tput setaf 2`$addrsnetcard5${normal}"	
#si existe pero no tiene direccion ip, lo muestra por pantalla y pregunta si quiere configurarla.
				else 
					echo -e " ${bold}$netcard5${normal} --> \e[1;31mNo tiene dirección IPv4 configurada o la interface está desactivada\e[0m"
				fi
		elif [ -z $netcard5 ]; then
					echo ""
fi


echo -e "\e[1;30m[0] Salir de SysAdminTool\e[0m"
echo -e "\e[1;30m[9] Retroceder una página\e[0m\n\n" 

read -p "Elija una opción: " respuestaif
							
