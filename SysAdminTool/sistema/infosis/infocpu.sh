#!/bin/bash
clear

#Variables de datos del equipo.

name=$(sudo hostname) #nombre del equipo
so=$(sudo uname -o) #sistema operativo
nameso=$(hostnamectl | grep "Operating System" | awk '{print $3,$4,$5}') #nombre de la version del sistema operativo
tiposo=$(sudo uname -m) #tipo del sistema operativo
kernel=$(hostnamectl | grep Kernel | awk '{print $2,$3,$4,$5,$6,$7,$8}') #nombre del kernel
sn=$(sudo dmidecode -t system | grep Serial | cut -d ':' -f2)
micro=$(cat /proc/cpuinfo | grep ^'model name' | awk '{print $4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14}')
ram=$(sudo vmstat -s -S M | grep "total memory" | awk '{ print $1, $2 }')
grafica=$(sudo lspci | grep VGA | awk '{ print $5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$20 }')
tarjetared=$(sudo lspci | grep "Ethernet Controller" | awk '{print $4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$20}')
disco=$(lsblk | grep 'disk' | awk '{print $1,$4}')


#Código del script



##Logo SysAdminTool
#tput setab 5
#echo -e "                _______  _______ ___    ____  __  ________   ____________  ____  __                 "
#echo -e "               / ___/\ \/ / ___//   |  / __ \/  |/  /  _/ | / /_  __/ __ \/ __ \/ /                 "
#echo -e "               \__ \  \  /\__ \/ /| | / / / / /|_/ // //  |/ / / / / / / / / / / /                  "
#echo -e "              ___/ /  / /___/ / ___ |/ /_/ / /  / // // /|  / / / / /_/ / /_/ / /___                "
#echo -e "             /____/  /_//____/_/  |_/_____/_/  /_/___/_/ |_/ /_/  \____/\____/_____/                "                                                                                  
#echo -e "                                                                                                    "
#tput sgr0
#Restaurar valores por defecto
tput sgr0

############################################
#					                       #
#	       MENSAJE DE BIENVENIDA           #
#					                       #
############################################

#Poner texto en negrita
tput bold

#Poner color de fondo + valor 3=orange
tput setaf 0
#echo -e "\n ---- Bienvenid@ a SysAdminTool ---- "
#echo " ---- Versión 1.0b para Ubuntu Server y Desktop 20.04 20-04-2022 ----"
#echo -e " ---- Desarrollado por David Jiménez Tena & Adrián Fernández Barquero ----\n"

#Restaurar valores por defecto
tput sgr0

############################################
#		                                   #
#	           MENÚ PRINCIPAL              #
#				                           #
############################################

#Poner color de fondo + valor 3=orange
tput setab 4
tput bold
echo -e "                                  I N F O - D E L - E Q U I P O                                     \n"

#Restaurar valores por defecto
tput sgr0
tput sgr0

tput setaf 3
echo " DATOS DEL SISTEMA"
tput sgr0 #Restaurar valores por defecto del texto

echo -e "\n`tput sgr0``tput bold` Nombre del equipo: `tput sgr0``tput setaf 2`$name"
echo "`tput sgr0``tput bold` Sistema Operativo: `tput sgr0``tput setaf 2`$so"
echo "`tput sgr0``tput bold` Nombre del SO: `tput sgr0``tput setaf 2`$nameso"
echo "`tput sgr0``tput bold` Tipo de SO: `tput sgr0``tput setaf 2`$tiposo"
echo "`tput sgr0``tput bold` Kernel: `tput sgr0``tput setaf 2`$kernel"
echo "`tput sgr0``tput bold` Serial Number:`tput sgr0``tput setaf 2`$sn "
