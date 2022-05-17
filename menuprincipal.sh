#!/bin/bash
# 22/04/2022
# Este script es el menú principal de SysAdminTool 1.0

############################################
#					  					   #
#       INICIALIZACIÓN DE VARIABLES        #
#					   					   #
############################################

num='^-?[0-9]+([.][0-9]+)?$'
ubicacion=$(pwd)

############################################

############################################
#					   #
#                PROGRAMA                  #
#					   #
############################################


#Creamos carpeta donde iran todos los ficheros que cree SysAdminTool

#mkdir /etc/SysAdminTool
#mkdir /etc/SysAdminTool/tmp

mkdir tmp

#if [ $ubicacion != '/etc/SysAdminTool' ]; then
#	mv * /etc/SysAdminTool
#	exit 0
#       echo "Se ha redirigido la carpeta SysAdminTool a /etc/SysAdminTool"
#	read -p "Pulse cualquier botón para continuar."
#fi

#mv * /etc/SysAdmintool

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
#					   #
#	    MENSAJE DE BIENVENIDA          #
#					   #
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
#		                           #
#	       MENÚ PRINCIPAL              #
#				           #
############################################

#Poner color de fondo + valor 3=orange
tput setab 4
tput bold
echo -e "                                  M E N Ú - P R I N C I P A L                                       \n"

#Restaurar valores por defecto
tput sgr0
tput setaf 3

echo -e "[ 1 ] HERRAMIENTAS DE RED.\n"

echo -e "[ 2 ] HERRAMIENTAS DE SISTEMA.\n"

echo -e "[ 3 ] HERRAMIENTAS DE SEGURIDAD.\n"

echo -e "[ 4 ] SERVICIOS DEDICADOS.\n"

echo -e "[ 5 ] ACCESOS REMOTOS.\n\n"

echo -e "\e[1;30m[0] Salir de SysAdminTool\e[0m\n"

#Poner texto en negrita
tput bold
read -p "Elige una opción: " choice0
tput sgr0
if [[ $choice0 =~ $num ]]; then
	case $choice0 in
	1)
		. ./red/menured.sh
	;;
	2)
		. ./sistema/menusis.sh
	;;
	3)
		. ./seguridad/menuseg.sh
	;;
	4)
		. ./servicios/menuserv.sh
	;;
	5)
		. ./remoto/menuremoto.sh
	;;
	0)
		clear
		echo -e "\nGracias por usar SysAdminTool\n"
		exit 0
	;;
esac

else
	. menuprincipal.sh
fi


