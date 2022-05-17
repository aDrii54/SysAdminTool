#!/bin/bash
clear

#traducción del comando free al español
free > ./sistema/infosis/inforam.txt

sed -i 's/total/Total/g' ./sistema/infosis/inforam.txt
sed -i 's/used/Usado/g' ./sistema/infosis/inforam.txt
sed -i 's/free/Libre/g' ./sistema/infosis/inforam.txt
sed -i 's/shared/Compartida/g' ./sistema/infosis/inforam.txt
sed -i 's/available/Disponible/g' ./sistema/infosis/inforam.txt
sed -i 's/Mem/Memoria/g' ./sistema/infosis/inforam.txt

#Variables de datos de la memoria RAM.
memoriatotal=$(cat ./sistema/infosis/inforam.txt | grep Memoria | awk '{print $2}')
memoriausada=$(cat ./sistema/infosis/inforam.txt | grep Memoria | awk '{print $3}')
memorialibre=$(cat ./sistema/infosis/inforam.txt | grep Memoria | awk '{print $4}')
memoriacompartida=$(cat ./sistema/infosis/inforam.txt | grep Memoria | awk '{print $5}')
memoriacache=$(cat ./sistema/infosis/inforam.txt | grep Memoria | awk '{print $6}')
memoriadisponible=$(cat ./sistema/infosis/inforam.txt | grep Memoria | awk '{print $7}')
swaptotal=$(cat ./sistema/infosis/inforam.txt | grep 'Swap' | awk '{print $2}')
swapusada=$(cat ./sistema/infosis/inforam.txt | grep 'Swap' | awk '{print $3}')
swaplibre=$(cat ./sistema/infosis/inforam.txt | grep 'Swap' | awk '{print $4}')
swapcompartida=$(cat ./sistema/infosis/inforam.txt | grep 'Swap' | awk '{print $5}')
swapcache=$(cat ./sistema/infosis/inforam.txt | grep 'Swap' | awk '{print $6}')
swapdisponible=$(cat ./sistema/infosis/inforam.txt | grep 'Swap' | awk '{print $7}')


#Comprueba si las variables devuelven valor

############################################
#					                       #
#	      COMPROBACIÓN - MEMORIA           #
#			 		                       #
############################################

#MEMORIA TOTAL

if [ $memoriatotal ];then
    memoriatotal=$memoriatotal
else
    memoriatotal=$("`tput setaf 1``tput bold`echo -e "No disponible"`tput sgr0`!\n")
fi


#MEMORIA USADA
if [ $memoriausada ];then
    memoriausada=$memoriausada
else
    tput setaf 1
    memoriatotal=$(echo "No disponible")
    tput sgr0
fi


#MEMORIA LIBRE
if [ $memorialibre ];then
    memorialibre=$memorialibre
else
    tput setaf 1
    memoriatotal=$(echo "No disponible")
    tput sgr0
fi


#MEMORIA COMPARTIDA
if [ $memoriacompartida ];then
    memoriacompartida=$memoriacompartida
else
    tput setaf 1
    memoriatotal=$(echo "No disponible")
    tput sgr0
fi


#MEMORIA CACHE
if [ $memoriacache ];then
    memoriacache=$memoriacache
else
    tput setaf 1
    memoriatotal=$(echo "No disponible")
    tput sgr0
fi

#MEMORIA DISPONIBLE
if [ $memoriadisponible ];then
    memoriadisponible=$memoriadisponible
else
    tput setaf 1
    memoriatotal=$(echo "No disponible")
    tput sgr0
fi


#Código del script

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
echo -e "                                          I N F O - R A M                                           \n"

#Restaurar valores por defecto
tput sgr0
tput sgr0

tput setaf 3 #Pone color del texto en naranja
echo -e " Memoria (KB)\n"
tput sgr0 #Restaurar valores por defecto del texto
echo " Total: `tput setaf 2`$memoriatotal KB`tput sgr0`"
echo " Usado: `tput setaf 2`$memoriausada KB`tput sgr0`"
echo " Libre: `tput setaf 2`$memorialibre KB`tput sgr0`"
echo " Compartida: `tput setaf 2`$memoriacompartida KB`tput sgr0`"
echo " Cache: `tput setaf 2`$memoriacache KB`tput sgr0`"
echo " Disponible: `tput setaf 2`$memoriadisponible KB`tput sgr0`"
echo -e "\n\n"



############################################
#					                       #
#	                SWAP                   #
#					                       #
############################################


tput setaf 3 #Pone color del texto en naranja
echo -e " Swap (KB)\n"
tput sgr0

#SWAP TOTAL
if [ $swaptotal ];then
    echo " Total: `tput setaf 2`$swaptotal KB`tput sgr0`"
else
    echo " Total: `tput setaf 1`No disponible`tput sgr0`"
fi


#SWAP USADA
if [ $swapusada ];then
    echo " Usado: `tput setaf 2`$swapusada KB`tput sgr0`"
else
    echo " Usado: `tput setaf 1`No disponible`tput sgr0`"
fi
#SWAP LIBRE
if [ $swaplibre ];then
    echo " Libre: `tput setaf 2`$swaplibre KB`tput sgr0`"
else
    echo " Libre: `tput setaf 1`No disponible`tput sgr0`"
fi
#SWAP COMPARTIDA
if [ $swapcompartida ];then
    echo " Compartida: `tput setaf 2`$swapcompartida KB`tput sgr0`"
else
    echo " Compartida: `tput setaf 1`No disponible`tput sgr0`"
fi
#SWAP CACHE
if [ $swapcache ];then
    echo " Cache: `tput setaf 2`$swapcache KB`tput sgr0`"
else
    echo " Cache: `tput setaf 1`No disponible`tput sgr0`"
fi
#SWAP DISPONIBLE
if [ $swapdisponible ];then
    echo " Disponible: `tput setaf 2`$swapdisponible KB`tput sgr0`"
else
    echo " Disponible: `tput setaf 1`No disponible`tput sgr0`"
fi

echo -e "\n"
echo -e "\e[1;30m[ 0 ] Salir de SysAdminTool\e[0m"
echo -e "\e[1;30m[ 9 ] Retroceder una página\e[0m\n\n"

read -p "Elige una opción: " respuesta


case $respuesta in
    0)
        clear
        echo -e "\n ¡Gracias por usar `tput bold``tput setaf 5`SysAdminTool`tput sgr0`!\n"
    ;;
    
    9)
        . ./sistema/infosis.sh
    ;;
esac

