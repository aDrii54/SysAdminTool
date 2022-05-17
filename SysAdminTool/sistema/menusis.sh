#!/bin/bash
# 22/04/2022
# Menú del Sistema -  SysAdminTool 1.0
#Limpiar la pantalla
tput clear
tput setab 5

restriccion_num='^-?[0-9]+([.][0-9]+)?$'

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
echo -e "                         H E R R A M I E N T A S - D E - S I S T E M A                              \n"

#Restaurar valores por defecto
tput sgr0
tput setaf 3

#Opciones de red
echo -e "[ 1 ] VER ESPECIFICACIONES DEL EQUIPO.\n"

echo -e "[ 2 ] CAMBIAR EL NOMBRE AL EQUIPO.\n"

echo -e "[ 3 ] VER ESTADO DEL EQUIPO.\n" #temperaturas del equipo

echo -e "[ 4 ] USUARIOS Y GRUPOS.\n"

echo -e "[ 5 ] PROCESOS.\n"

echo -e "\e[1;30m[ 0 ] Salir de SysAdminTool\e[0m"
echo -e "\e[1;30m[ 9 ] Retroceder una página\e[0m\n\n"

read -p "Elige una opción: " choice1
tput sgr0
if [[ $choice1 =~ $restriccion_num ]]; then
 	case $choice1 in

	1)
		clear
		. ./sistema/infosis.sh
	;;

	2)
		clear
		. ./sistema/cambionombrepc.sh
	;;

	3)
		clear
		. process.sh
	;;

	4)
		clear
		showstatepc.sh
	;;

	5)
		clear
		usersygroups.sh
	;;
	0)
		clear
		echo -e "\n ¡Gracias por usar `tput setaf 5``tput bold`SysAdminTool`tput sgr0`!\n"
		exit 0
	;;
	9)
		. menuprincipal.sh
	;;
	*)
		. ./sistema/menusis.sh
	;;
esac
else
	. ./sistema/menusis.sh	
fi


