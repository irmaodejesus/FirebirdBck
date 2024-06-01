#!/bin/bash

# Copyright (c) [2024] [EMMANUEL T. PEIXOTO]
# Licensed under the MIT License. See LICENSE file in the project root for full license information.
# page official of project https://github.com/irmaodejesus/SYSADMIN..FirebirdBck

# File log name.
log_file="/var/log/log.FirebirdBck"

# Function to write log messages
log_message() {
    echo "$(date +"%Y-%m-%d %T") - $1" >> "$log_file"
}

log_message " ---> EXEC FirebirdBckCtrSVC.sh"

# Definir o caminho para o arquivo de configuração
CONFIG_FILE="/etc/firebirdbck/FirebirdBck.conf"

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

# The name of the service of the database.
test_empty_var "DB_SVC_NAME"

if [ "$1" == "start" ]; then
    # Checks if the service is active, and if it isn't, starts it
    if systemctl is-active --quiet $DB_SVC_NAME; then
        log_message "The $DB_SVC_NAME service is already started."
    else
        log_message "Starting service...."
        sudo systemctl start $DB_SVC_NAME
        log_message "The $DB_SVC_NAME service has been started."
    fi
elif [ "$1" == "stop" ]; then
    # Checks if the service is active, and if it is, stops it
    if systemctl is-active --quiet $DB_SVC_NAME; then
        log_message "Stopping service...."
        sudo systemctl stop $DB_SVC_NAME
        log_message "The $DB_SVC_NAME service has been stopped."
    else
        log_message "The $DB_SVC_NAME service is already stopped."
    fi
else
    echo "Usage: $0 [start|stop]"
fi