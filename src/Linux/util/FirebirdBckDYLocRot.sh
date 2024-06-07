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

START_MSG="====== GETTING STARTED SAVES SPACE DY LOC======"
STOP_MSG="======== FINISHED SAVES SPACE DY LOC======="

#  Logging Functions
log_message() {
    level="$1"
    message="$2"
    echo "$(date +"%Y-%m-%d %T") - $level - $message" >> "$log_file"
}

log_message  "$L_INFO" " ---> EXEC FirebirdBckDYLocRot.sh"

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

# Checking the required variable
test_empty_var "FOLDER_BKP_LOCAL"

#  Verify that all folders exist and create them
base_nome=$FOLDER_BKP_LOCAL/day
total_pastas=7

for ((i=1; i<=total_pastas; i++)); do
    local teste_pasta="${base_nome}${i}"

    if [ ! -d "$teste_pasta" ]; then
        log_message  "$L_INFO" "The $teste_pasta does not exist."
        sudo mkdir -p $teste_pasta
        log_message  "$L_INFO" "Folder created"            
    fi
done

# Define the folders that contain the local backups
pastas=("$FOLDER_BKP_LOCAL/day1" "$FOLDER_BKP_LOCAL/day2" "$FOLDER_BKP_LOCAL/day3" "$FOLDER_BKP_LOCAL/day4" "$FOLDER_BKP_LOCAL/day5" "$FOLDER_BKP_LOCAL/day6" "$FOLDER_BKP_LOCAL/day7")
# Get the current day and the previous two days
hoje=$(date +%u)
dia_anterior1=$(( (hoje + 6 - 1) % 7 + 1 ))
dia_anterior2=$(( (hoje + 6 - 2) % 7 + 1 ))
# Keep content from the current day and the previous two days
pastas_a_manter=("$FOLDER_BKP_LOCAL/day$hoje" "$FOLDER_BKP_LOCAL/day$dia_anterior1" "$FOLDER_BKP_LOCAL/day$dia_anterior2")

log_message "$L_INFO" "$START_MSG"

# Check to see if a folder is in the list of folders to keep.
for pasta in "${pastas[@]}"; do
    if [[ " ${pastas_a_manter[*]} " == *" $pasta "* ]]; then
        log_message "$L_INFO" "Content held in $pasta"
    else
        rm -rf "$pasta"/* 
        log_message "$L_SCES" "Deleted content from $pasta"
    fi
done

log_message "$L_INFO" "$STOP_MSG"
