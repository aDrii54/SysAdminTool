#!/bin/bash

#menú remoto
#Limpiar la pantalla
tput clear
tput setab 5


#Logo SysAdminTool
echo -e "                _______  _______ ___    ____  __  ________   ____________  ____  __                 "
echo -e "               / ___/\ \/ / ___//   |  / __ \/  |/  /  _/ | / /_  __/ __ \/ __ \/ /                 "
echo -e "               \__ \  \  /\__ \/ /| | / / / / /|_/ // //  |/ / / / / / / / / / / /                  "
echo -e "              ___/ /  / /___/ / ___ |/ /_/ / /  / // // /|  / / / / /_/ / /_/ / /___                "
echo -e "             /____/  /_//____/_/  |_/_____/_/  /_/___/_/ |_/ /_/  \____/\____/_____/                "                                                                                  
echo -e "                                                                                                    "
tput sgr0
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
echo -e "                                  A C C E S O S - R E M O T O S                                     \n"

#Restaurar valores por defecto
tput sgr0
tput setaf 3

#Opciones de red
echo -e "[ 1 ] ACCESO REMOTO VÍA (SSH).\n"

echo -e "[ 2 ] ACCESO REMOTO VÍA (TELNET).\n"

echo -e "[ 3 ] APACHE GUACAMOLE.\n" #temperaturas del equipo

echo -e "\e[1;30m[ 0 ] Salir de SysAdminTool\e[0m"
echo -e "\e[1;30m[ 9 ] Retroceder una página\e[0m\n\n"

read -p "Elige una opción: " respuesta

case $respuesta in
	1)
		clear
		. ./remoto/ssh.sh
	;;

	2)
		clear
		. ./remoto/telnet.sh
	;;

	3)
		clear
		. ./remoto/guacamole.sh
	;;
	0)
		clear
		echo -e "\n ¡Gracias por usar `tput setaf 5``tput bold`SysAdminTool`tput sgr0`!\n" | timeout -s 3
		echo -e "\n ¡Gracias por usar `tput setaf 5``tput bold`SysAdminTool`tput sgr0`!\n" | timeout -s 3

		exit 0
	;;
	9)
		. menuprincipal.sh
	;;
esac


