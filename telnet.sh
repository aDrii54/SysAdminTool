#!/bin/bash

#  Conexión por telnet
#  13-05-2022
#  SysAdminTool V1.0



############################################
#		                                   #
#	           MENÚ PRINCIPAL              #
#				                           #
############################################

#Poner color de fondo + valor 3=orange
tput setab 4
tput bold
echo -e "                                 A C C E S O - P O R - T E L N E T                                  \n"

#Restaurar valores por defecto
tput sgr0
tput setaf 3

#Opciones de red
echo -e "`tput setaf 7`Introduce la dirección IP y nombre de usuario del equipo al que se quiera conectar.`tput sgr0`\n"
read -p "Dirección IP: `tput setaf 2`" ip 
tput sgr0
read -p "Nombre de usuario: `tput setaf 3`" usuario
tput sgr0
echo -e "\n\n"

read -p "¿Desea conectarse al equipo `tput setaf 2`$ip`tput sgr0` con el usuario `tput setaf 3`$usuario`tput sgr0`? [s/n]" respuesta

case $respuesta in
    s)
       telnet $ip
    ;;
    n)
        . ./remoto/menuremoto.sh
    ;;

esac