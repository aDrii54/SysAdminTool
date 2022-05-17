#!/bin/bash
#_______________________________________________________________________________________________________________________________________________________________________________________________
#  Conexión por SSH
#  13-05-2022
#  SysAdminTool V1.0
#_______________________________________________________________________________________________________________________________________________________________________________________________


############################################
#		                                   #
#	             VARIABLES                 #
#				                           #
############################################

statusufw=$(ufw status | grep Status | awk '{print $2}') #Te devuelve el estado que tiene UFW (se usará más adelante en un condicional).
portssh=$(cat /etc/ssh/sshd_config | grep "Port " | awk '{print $2}') #Comprueba el puerto que tienes configurado para permitir la conexión SSH dentro del archivo "sshd_config" que es el archivo de configuración de ssh
sshufw=$(ufw status | grep $portssh | awk '(NR == 1){print $2}') #Comprueba si hay alguna regla creada en UFW que tenga abierto el puerto que tengamos configurado por SSH


############################################
#		                                   #
#	           MENÚ PRINCIPAL              #
#				                           #
############################################

#Poner color de fondo + valor 3=orange
tput setab 4
tput bold
echo -e "                                  A C C E S O - P O R - S S H                                       \n"

#Restaurar valores por defecto
tput sgr0
tput setaf 3

#Mensajes solicitud de datos
echo -e "`tput setaf 7`Introduce la dirección IP y nombre de usuario del equipo al que se quiera conectar.`tput sgr0`\n"
read -p "Dirección IP: `tput setaf 2`" ip 
tput sgr0
read -p "Nombre de usuario: `tput setaf 3`" usuario
tput sgr0
echo -e "\n"

read -p "¿Desea conectarse al equipo `tput setaf 2`$ip`tput sgr0` con el usuario `tput setaf 3`$usuario`tput sgr0`? [s/n] " respuesta  

case $respuesta in
    s)
    if [[ $statusufw == "active" ]]; then #Comprueba si el UFW está activado
        if [[ $sshufw == "ALLOW" ]]; then #Si UFW está activado, pasa a comprobar si hay una regla en UFW que permita la conexión por el puerto configurado en el server para SSH
                echo -e "\n"
                echo -e "`tput setaf 2`CONECTANDO...`tput sgr0`"
                sleep 2
                clear
                ssh $usuario@$ip
            else 
                echo -e "\n"
                echo "`tput setaf 3`UFW no tiene ninguna regla que habilite la conexión por el puerto configurado para la conexión SSH`tput sgr0`"
                read -p "¿Desea añadir una regla que permita la conexión por SSH a través del puerto $portssh? [s/n] " respuesta 
                if [[ $respuesta == "s" ]];then
                    clear
                    tput setab 4
                    tput bold
                    echo -e "                                  A C C E S O - P O R - S S H                                       \n"
                    tput sgr0
                    echo -e "`tput setaf 2`Añadiendo regla para permitir conexión por el puerto $portssh`tput sgr0`\n"
                    sleep 2
                    ufw allow $portssh/tcp
                    clear
                    tput setab 4
                    tput bold
                    echo -e "                                  A C C E S O - P O R - S S H                                       \n"
                    tput sgr0
                    echo -e "`tput setaf 2`CAMBIOS REALIZADOS CON ÉXITO.`tput sgr0`"
                    echo -e "`tput setaf 2`CONECTANDO NUEVAMENTE CON EL EQUIPO $ip Y EL USUARIO $usuario...`tput sgr0`"
                    sleep 2
                    ssh $usuario@$ip

                elif [[ $respuesta == "n" ]];then
                    clear
                    . ./remoto/ssh.sh
                else
                    . ./remoto/ssh.sh
                fi
            fi
    elif [[ $statusufw == "inactive" ]];then
            echo -e "\n"
            echo -e "`tput setaf 1``tput bold`UFW se encuentra deshabilitado, es necesario habilitar UFW`tput sgr0`"
            read -p "Pulse `tput setaf 3`ENTER`tput sgr0` para continuar y habilitar todo automáticamente."

            clear
            tput setab 4
            tput bold
            echo -e "                                  A C C E S O - P O R - S S H                                       \n"
            tput sgr0
            echo -e "`tput setaf 2`HABILITANDO FIREWALL UFW...`tput sgr0`\n"
            sleep 2
            ufw enable #Habilita UFW
            clear
            tput setab 4
            tput bold
            echo -e "                                  A C C E S O - P O R - S S H                                       \n"
            tput sgr0
            echo -e "`tput setaf 2`UFW HABILITADO CORRECTAMENTE.`tput sgr0`\n"
            sshufw=$(ufw status | grep $portssh | awk '(NR == 1){print $2}')
        if [[ $sshufw == "ALLOW" ]]; then #Si UFW está activado, pasa a comprobar si hay una regla en UFW que permita la conexión por el puerto configurado en el server para SSH
                echo -e "`tput setaf 2`CONECTANDO...`tput sgr0`"
                sleep 2
                clear
                ssh $usuario@$ip
        else  #Si no existe la regla, te la crea automáticamente.
            echo "`tput setaf 3`UFW no tiene ninguna regla que habilite la conexión por el puerto configurado para la conexión SSH`tput sgr0`"
            read -p "¿Desea añadir una regla que permita la conexión por SSH a través del puerto $portssh? [s/n] " respuesta
            if [[ $respuesta == "s" ]];then
                clear
                tput setab 4
                tput bold
                echo -e "                                  A C C E S O - P O R - S S H                                       \n"
                tput sgr0
                echo -e "`tput setaf 2`AÑADIENDO REGLA PARA PERMITIR CONEXIÓN POR EL PUERTO $portssh`tput sgr0`\n"
                sleep 2
                ufw allow $portssh/tcp #CREACIÓN DE LA REGLA
                clear
                tput setab 4
                tput bold
                echo -e "                                  A C C E S O - P O R - S S H                                       \n"
                tput sgr0
                echo -e "`tput setaf 2`CAMBIOS REALIZADOS CON ÉXITO.`tput sgr0`"
                sleep 2
                echo -e "`tput setaf 2`CONECTANDO NUEVAMENTE CON EL EQUIPO `tput setaf 3`$ip`tput sgr0``tput setaf 2` Y EL USUARIO `tput setaf 3`$usuario`tput sgr0``tput setaf 2`...`tput sgr0`\n"
                sleep 2
                clear
                ssh $usuario@$ip # CONECTA POR SSH
            elif [[ $respuesta == "n" ]];then
                clear
                . ./remoto/ssh.sh
            else
                        . ./remoto/ssh.sh
            fi
        fi
    fi   
    ;;
    n)
        . ./remoto/menuremoto.sh
    ;;
esac
