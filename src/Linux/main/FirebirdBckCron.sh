# Copyright (c) [2024] [EMMANUEL T. PEIXOTO]
# Licensed under the MIT License. See LICENSE file in the project root for full license information.
# page official of project https://github.com/irmaodejesus/SYSADMIN.FirebirdBck


#!/bin/bash

# Log file name and configuration file defined by environment variables
log_file="${LOG_FILE:-/var/log/log.FirebirdBck}"
CONFIG_FILE="${CONFIG_FILE:-/etc/firebirdbck/FirebirdBck.conf}"

CONFIG_NOT_FOUND_MSG=" Config File $CONFIG_FILE Not Found!"
EMPTY_VAR_MSG=" The variable '%s' is empty."
MSG_NO_ROOT=" This script must be run as root"
L_ERROR="ERROR "
L_INFO="INFO "
L_SCES="SUCCESS "

#  Logging Functions
log_message() {
    level="$1"
    message="$2"
    echo "$(date +"%Y-%m-%d %T") - $level - $message" >> "$log_file"
}

log_message  "$L_INFO" " ---> EXEC FirebirdBckCron.sh"

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

test_empty_var "MOUNT_POINT"

#Aqui entra todo o procedimento de backup.
# 1 - desliga o servico do banco

# 2 - faz dayrotation local

# 3 - faz o backup de todos os bancos

# 4 - monta repositorio remoto

# 5 - envia a copia do dia para o remoto

# 6 - faz o day rotation remoto

# 7 - faz o week rotation remoto 

# 8 - faz o month rotation remoto 

# 9 - desmonta o compartilhamento remoto

# 10 - inicia os servicos do banco
