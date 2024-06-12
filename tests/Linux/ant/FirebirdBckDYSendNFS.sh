# Copyright (c) [2024] [EMMANUEL T. PEIXOTO]
# Licensed under the MIT License. See LICENSE file in the project root for full license information.
# page official of project https://github.com/irmaodejesus/SYSADMIN.FirebirdBck


#!/usr/bin/env bash

# Log file name and configuration file defined by environment variables
log_file="${LOG_FILE:-/var/log/log.FirebirdBck}"
CONFIG_FILE="${CONFIG_FILE:-/etc/firebirdbck/FirebirdBck.conf}"

CONFIG_NOT_FOUND_MSG=" Config File $CONFIG_FILE Not Found!"
EMPTY_VAR_MSG=" The variable '%s' is empty."
MSG_NO_ROOT=" This script must be run as root"
L_ERROR="ERROR "
L_INFO="INFO "
L_SCES="SUCCESS "

START_MSG="=====================START SEND DAILY BACKUP ============"
STOP_MSG="=====================START SEND DAILY BACKUP ============"

# Get the day of the week (1 to 7, where 1 is Monday and 7 is Sunday).
dia_da_semana=$(date +%u)

#  Logging Functions
log_message() {
    level="$1"
    message="$2"
    echo "$(date +"%Y-%m-%d %T") - $level - $message" >> "$log_file"
}

log_message  "$L_INFO" " ---> EXEC FirebirdBckDYSend.sh"

# Superuser Verification
if [ "$EUID" -ne 0 ]; then
    log_message "$L_ERRO" "$MSG_NO_ROOT"
    exit 1
fi

# Check if the config file exists
if [ ! -f "$CONFIG_FILE" ]; then
    log_message "$L_ERRO" "$CONFIG_NOT_FOUND_MSG"
    exit 1
fi

# Upload the configuration file
source "$CONFIG_FILE"

# Function to test if a variable is empty
test_empty_var() {
    local var_name="$1"
    local var_value="${!var_name}"
    if [ -z "$var_value" ]; then
        log_message "$L_ERRO" "$(printf "$EMPTY_VAR_MSG" "$var_name")"
        exit 1
    fi
}

test_empty_var "FOLDER_BKP_LOCAL"
test_empty_var "MOUNT_POINT"
test_empty_var "IP_REMOTE_SERVER"
test_empty_var "SHARE_NFS"

# verify that an NFS share is mounted
share_nfs="$IP_REMOTE_SERVER:$SHARE_NFS"

if mount | grep -q "$cshare_nfs"; thenn
    log_message "$L_INFO" "$share_nfs mounted."
       
else
    log_message "$L_ERRO" "$share_nfs NOT mounted."
    exit 1
fi

#  Verify that all folders exist and create them
base_nome=$MOUNT_POINT/firebirdbck/day
total_pastas=7

for ((i=1; i<=total_pastas; i++)); do
    local teste_pasta="${base_nome}${i}"

    if [ ! -d "$teste_pasta" ]; then
        log_message  "$L_INFO" "The $teste_pasta does not exist."
        sudo mkdir -p $teste_pasta
        log_message  "$L_INFO" "Folder created"            
    fi
done

# INCLUIR AQUI FUNCAO PARA VERIFICAR SE A FOLDER DE ORIGEM ESTA VAZIA.

# local  folder
localfolder="$FOLDER_BKP_LOCAL/day$dia_da_semana"
# destination folder folder
remotefolder="$MOUNT_POINT/firebirdbck/day$dia_da_semana"

log_message "$L_INFO" "$START_MSG"

# AQUI INCLUIR FUNCAO DE VERIFICACAO DE ESPACO DISPONIVEL

# 1st deleted content of remote folder refer this day of before backup
sudo rm -rf "$remotefolder"/*
log_message "$L_SCES" "Content deleted $remotefolder/* "

# Copy the local folder to the folder corresponding to the day
sudo cp -r "$localfolder"/* "$remotefolder"/
log_message "$L_SCES" "Backup copied to $remotefolder"

#AQUI INCLUI VERIFICACAO DA INTEGRIDADE DA COPIA
log_message "$L_SCES" "$STOP_MSG"
