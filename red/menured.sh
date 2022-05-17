#!/bin/bash
# 22/04/2022
# Menú de red - SysAdminTool 1.0

############################################
#								           #
#	    INICIALIZACIÓN DE VARIABLES        # 
#									       #
############################################

restriccion_num='^-?[0-9]+([.][0-9]+)?$'

############################################

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
echo -e "                              H E R R A M I E N T A S - D E - R E D                                 \n"

#Restaurar valores por defecto
tput sgr0
tput setaf 3

#Opciones de red

echo -e "[ 1 ] VER IPv4 Y CONFIGURAR TARJETAS DE RED.\n"

echo -e "[ 2 ] VER IP PÚBLICA DE RED.\n"

echo -e "\e[1;30m[0] Salir de SysAdminTool\e[0m"
echo -e "\e[1;30m[9] Retroceder una página\e[0m\n\n"

#Opciones de red

read -p " Elige una opción: " choice1
tput sgr0

if [[ $choice1 =~ $restriccion_num ]]; then
 	case $choice1 in
	1)
		. ./red/configurarip.sh
	;;
	2)
		. ./red/verippublica.sh
	;;
	0)
		clear
		tput sgr0
		echo -e "\n ¡Gracias por usar `tput setaf 5``tput bold`SysAdminTool`tput sgr0`!\n"
		exit 0
	;;
	9)
		. menuprincipal.sh
	;;
esac	
else
	. ./red/menured.sh	
fi
