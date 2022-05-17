#!/bin/bash
clear

#Variables de datos del equipo.
nombre=$(hostname)

#Código del script



############################################
#		                                   #
#	           MENÚ PRINCIPAL              #
#				                           #
############################################

#Poner color de fondo + valor 3=orange
tput setab 4
tput bold
echo -e "                              C A M B I O - N O M B R E - D E L - P C                               \n"

#Restaurar valores por defecto
tput sgr0
tput sgr0

echo -e "`tput setaf 3`Nombre actual del equipo: `tput sgr0``tput setaf 2`$nombre\n"
tput sgr0
echo -e "____________________________________________________________________________________________________\n"
read -p "¿Desea cambiar el nombre del equipo [`tput setaf 2`s`tput sgr0`/`tput setaf 1`n`tput sgr0`]? " respuesta

case $respuesta in
s)
    clear
    tput setab 4
    tput bold
    echo -e "                              C A M B I O - N O M B R E - D E L - P C                               \n"

    #Restaurar valores por defecto
    tput sgr0
    echo -e "`tput setaf 3`Nombre actual del equipo: `tput sgr0``tput setaf 2`$nombre\n"
    tput sgr0
    echo -e "____________________________________________________________________________________________________\n"
    read -p "Introduzca el nuevo nombre del equipo: `tput setaf 2`" nombre1
    tput sgr0


    if [ $nombre ];then
    clear
    tput setab 4
    tput bold
    echo -e "                              C A M B I O - N O M B R E - D E L - P C                               \n"

    #Restaurar valores por defecto
    tput sgr0
    echo -e "Nombre actual del equipo: `tput sgr0``tput setaf 2`$nombre\n"
    tput sgr0
    echo -e "____________________________________________________________________________________________________\n"
    echo -e "El nombre del equipo pasara a ser: `tput setaf 2`"$nombre1"`tput sgr0`                      "
        echo -e "\n\n                                        `tput setab 1` ***ADVERTENCIA*** "
        echo -e "\n`tput sgr0``tput setaf 1`                      Para cambiar el nombre es necesario reiniciar el equipo`tput sgr0`\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"
        read -p "                                     Pulse `tput setaf 3`ENTER`tput sgr0` para reiniciar  "
        echo -e "$nombre1">/etc/hostname
        reboot now
    fi
;;
n)
    . ./sistema/menusis.sh
;;
*)
    . ./sistema/cambionombrepc.sh
;;
esac