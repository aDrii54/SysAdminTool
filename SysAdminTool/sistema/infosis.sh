#!/bin/bash
clear

#Variables de datos del equipo.

name=$(sudo hostname) #nombre del equipo
so=$(sudo uname -o) #sistema operativo
nameso=$(hostnamectl | grep "Operating System" | awk '{print $3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$20}') #nombre de la version del sistema operativo
tiposo=$(sudo uname -m) #tipo del sistema operativo
kernel=$(hostnamectl | grep Kernel | awk '{print $2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$20}') #nombre del kernel
sn=$(sudo dmidecode -t system | grep Serial | cut -d ':' -f2)
micro=$(cat /proc/cpuinfo | grep ^'model name' | awk '{print $4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$20}')
ram=$(sudo vmstat -s -S M | grep "total memory" | awk '{ print $1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$20}')
grafica=$(sudo lspci | grep VGA | awk '{ print $5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$20}')
tarjetared=$(sudo lspci | grep "Ethernet Controller" | awk '{print $4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19,$20}')
disco=$(lsblk | grep 'disk' | awk '{print $1,$4}')


#Pasar datos detallados a otros archivos

#Código del script

tput sgr0

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


tput setaf 3
echo -e ""
echo " HARDWARE DEL EQUIPO"

tput sgr0
echo -e "\n`tput sgr0``tput bold` Microprocesador: `tput sgr0``tput setaf 2`$micro "
echo "`tput sgr0``tput bold` Memoria RAM: `tput sgr0``tput setaf 2`$ram"
echo "`tput sgr0``tput bold` Tarjeta gráfica: `tput sgr0``tput setaf 2`$grafica"
echo -e "`tput sgr0``tput bold` Tarjeta de red: `tput sgr0``tput setaf 2`$tarjetared"
echo -e "`tput sgr0``tput bold` Disco duro principal: `tput sgr0``tput setaf 2`$disco \n"

echo -e "`tput sgr0``tput bold`____________________________________________________________________________________________________`tput sgr0``tput setaf 2`\n"

echo -e "`tput sgr0``tput setaf 3`[ 1 ] Obtener información detallada de [RAM]"
echo -e "`tput sgr0``tput setaf 3`[ 2 ] Obtener información detallada de [CPU]"
echo -e "`tput sgr0``tput setaf 3`[ 3 ] Obtener información detallada de [DISCOS DUROS]"
echo -e "`tput sgr0``tput setaf 3`[ 4 ] Obtener información detallada de [TARJETA DE RED]\n\n"

tput sgr0

echo -e "\e[1;30m[ 0 ] Salir de SysAdminTool\e[0m"
echo -e "\e[1;30m[ 9 ] Retroceder una página\e[0m"

echo -e "`tput sgr0``tput bold`____________________________________________________________________________________________________`tput sgr0``tput setaf 2`\n\n"

#Devuleve los valores de la apariencia del texto por defecto
tput sgr0
read -p "Elige una opción:  " respuesta

case $respuesta in
1)
    . ./sistema/infosis/inforam.sh
;;
2)
    . ./sistema/infosis/infocpu.sh
;;
3)
    . ./sistema/infosis/infohdd.sh
;;
4)
    . ./sistema/infosis/infotred.sh
;;
5)
    . ./sistema/infosis/infogpu.sh
;;
0)
    clear
    echo -e "\n ¡Gracias por usar `tput bold``tput setaf 5`SysAdminTool`tput sgr0`!\n"
    ;;
9)
    . ./sistema/menusis.sh
;;
esac
