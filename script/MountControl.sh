#!/bin/bash

# File log name.
log_file="/var/log/log.MountControl"

# The name of the service of the database.
log_message() {  echo "$(date +"%Y-%m-%d %T") - $1" >> "$log_file" }

# MSG mount
msg_mount() {   log_message "=====================START MOUNT SHARE FOLD ============"}

# MSG umount
msg_umount() {  log_message "===================START UMOUNT SHARE FOLDER============="}

# arguments
MOUNT_UMOUNT="$1"

# Definir o caminho para o arquivo de configuração
CONFIG_FILE="/etc/FirebirdBck.conf"

# Verificar se o arquivo de configuração existe
if [ ! -f "$CONFIG_FILE" ]; then
    log_message "Arquivo de configuração $CONFIG_FILE não encontrado!"
    exit 1
fi

# Carregar o arquivo de configuração
source $CONFIG_FILE

# Função para testar se uma variável está vazia
test_empty_var() {
    local var_name="$1"
    local var_value="${!var_name}"
    if [ -z "$var_value" ]; then
        log_message "A variável '$var_name' está vazia."
        exit 1;
    fi
}

if [ "$MOUNT_UMOUNT" == "mount" ]; then
    msg_mount
    test_empty_var "MOUNT_POINT"
    test_empty_var "IP_REMOTE_SERVER"
    test_empty_var "SHARE_NFS"
    
    # mount share NFS in local mount
    sudo mount -t nfs "$IP_REMOTE_SERVER":"$SHARE_NFS" "$MOUNT_POINT"
    
    # check if mounted
    if [ $? -eq 0 ]; then
       log_message "Share NFS mounted of $MOUNT_POINT"
       log_message "=======END MOUNT - SUCESS MOUNT SHARE ========="
       exit 0
    else
       log_message "Don't possible mount NFS share of  $MOUNT_POINT"    
       log_message "=======END MOUNT - IMPOSSIBLE MOUNT SHARE ========="
       exit 1
    fi
elif [ "$MOUNT_UMOUNT" == "umount" ]; then
    msg_umount
    test_empty_var "MOUNT_POINT"
    
    # Umount shre folder NFS
    sudo umount "$MOUNT_POINT"

    # check if umounted
    if [ $? -eq 0 ]; then
       log_message "Share NFS mounted of $MOUNT_POINT"
       log_message "=======END UMOUNT - SUCESS UMOUNT SHARE ========="
       exit 0
    else
       log_message "Don't possible mount NFS share of $MOUNT_POINT"    
       log_message "=======END UMOUNT - IMPOSSIBLE UMOUNT SHARE ========="
       exit 1
    fi
else
    log_message "Wrong arguments --> Use: $0 mount|umount "
fi