#!/bin/bash

# File log name.
log_file="/var/log/log.SendDayBack"
# Get the day of the week (1 to 7, where 1 is Monday and 7 is Sunday).
dia_da_semana=$(date +%u)
# arguments
localbackfolder="$1"
localmount="$2"

# local  folder
localfolder="$localbackfolder/FirebirdBack/day$dia_da_semana"
# destination folder folder
destinationfolder="$localmount/FirebirdBack/day$dia_da_semana"

# The name of the service of the database.
log_message() {
    echo "$(date +"%Y-%m-%d %T") - $1" >> "$log_file"
}

# MSG sstart
msg_start() {
    log_message "=====================START SEND DAILY BACKUP ============"
}

# Função para exibir mensagem de término do backup
msg_end() {
    log_message "=============DAILY BACKUP SENT========="
}

msg_start
# Check if the number of arguments is correct.
if [ $# -ne 2 ]; then
    log_message "Wrong arguments --> Use: $0 /backup/folder/ /folder/of/mount"
    exit 1
#fi

#AQUI INCLUIR VERIFICACAO DE ESPACO DISPONIVEL

# 1st deleted content of remote folder refer this day of before backup
sudo rm -rf "$destinationfolder"/*
log_message "Content of $destinationfolder/* deleted"

# Copiar a pasta local para a pasta correspondente ao dia no compartilhamento NFS
sudo cp -r "$localfolder"/* "$destinationfolder"/

#AQUI INCLUI VERIFICACAO DA INTEGRIDA DA COPIA
msg_end