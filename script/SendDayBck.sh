#!/bin/bash

# File log name.
log_file="/var/log/log.SendDayBack"
# Get the day of the week (1 to 7, where 1 is Monday and 7 is Sunday).
dia_da_semana=$(date +%u)
# arguments
localbackfolder="$1"
servershare="$2"
localmount="$3"

# local  folder
localfolder="$localbackfolder/FirebirdBack/day$dia_da_semana"
# destination folder folder
destinationfolder="$localmount/FirebirdBack/day$dia_da_semana"

# The name of the service of the database.
log_message() {
    echo "$(date +"%Y-%m-%d %T") - $1" >> "$log_file"
}

# MSG sstart
msg_inicio() {
    log_message "=====================START SEND DAILY BACKUP ============"
}

# Função para exibir mensagem de término do backup
msg_termino() {
    log_message "=============DAILY BACKUP SENT========="
}

msg_inicio
# Check if the number of arguments is correct.
if [ $# -ne 3 ]; then
    log_message "Wrong arguments --> Use: $0 /backup/folder/ ip:/folder/of/share/nfs /folder/of/mount"
    exit 1
#fi

# Montar o compartilhamento NFS
sudo mount -t nfs "$servershare" "$localmount"

# check if mounted
if [ $? -eq 0 ]; then
    log_message "Share NFS mounted of $localmount"
else
    log_message "Don't possible mount NFS share of $localmount"
    
    log_message "=======COPY TO REMOTE FOLDER NOT COMPLETE ========="
    exit 1
fi

# 1st deleted content of remote folder refer this day of before backup
sudo rm -rf "$pasta_destino"/pdv/*
log_message "Content of $destinationfolder/* deleted"

# Copiar a pasta local para a pasta correspondente ao dia no compartilhamento NFS
sudo cp -r "$localfolder"/* "$destinationfolder"/