# Copyright (c) [2024] [EMMANUEL T. PEIXOTO]
# Licensed under the MIT License. See LICENSE file in the project root for full license information.
# page official of project https://github.com/irmaodejesus/SYSADMIN.FirebirdBck


#!/usr/bin/env bash

#**************************************************************
#  Logging Functions
#
#**************************************************************
log_message() {
    level="$1"
    message="$2"
    echo "$(date +"%Y-%m-%d %T") - $level - $message" >> "$LOG_FILE"
}

#**************************************************************
# send to log file exec
#
#**************************************************************
_log__send_exec_file() {
    log_message  "$L_INFO" " ---> $1"
}

#**************************************************************
# Superuser Verification
# 
#**************************************************************
_is_root() {
if [ "$EUID" -ne 0 ]; then
    log_message "$L_ERRO" "$MSG_NO_ROOT"
    return 1
fi
}

#**************************************************************
# Check if the config file exists
# 
#**************************************************************
_exist_config_file(){
if [ ! -f "$CONFIG_FILE" ]; then
    log_message "$L_ERRO" "$CONFIG_NOT_FOUND_MSG"
    return 1
fi
}

#**************************************************************
# Checks if the variable is empty
# 
#**************************************************************
_test_empty_var() {
    local var_name="$1"
    local var_value="${!var_name}"
    if [ -z "$var_value" ]; then
        log_message "$L_ERRO" "$(printf "$EMPTY_VAR_MSG" "$var_name")"
        Return 1
    fi
}

#**************************************************************
# Function to call the scripts 
#
#**************************************************************
_call_script() {
    # Calls the passed script as an argument
    cd $FOLDER_INSTALL/bin
    ./"$1"

    # Verifies that the script has finished successfully
    if [ $? -eq 0 ]; then
        log_message "$L_SCES" " $1" 
        return 0
    else
        log_message "$L_ERRO" " $1"
        return 1  # Exits the script if one of the scripts fails
    fi
}

#**************************************************************
# checking the minimum space required
#
#**************************************************************
_minimum_free_size(){
    # Minimum size required in bytes (100 GB = 107374182400 bytes)
    local size_minim="$SIZE_FREE"

    # Obtém o tamanho da pasta em bytes
    local _size=$(df --output=avail "$1" | tail -n 1)

    # Checks if the size is larger than the minimum required
    if [ "$_size" -gt "$size_minim" ]; then
      log_message "$L_SCES" " $MSG_SPACE_FREE $1" 
        return 0
    else
        log_message "$L_ERRO" " $MSG_SPACE_NOT_FREE $1" 
        return 1 
    fi
}

#**************************************************************
# enable the database service
#
#**************************************************************
_start_db_service() { 
    if systemctl is-active --quiet "$DB_SVC_NAME"; then
        log_message "$L_INFO" "$DB_SVC_NAME $ALREADY_STARTED_MSG"
    else
        log_message "$L_INFO" "$START_MSG"
        sudo systemctl start "$DB_SVC_NAME"
        log_message "$L_SCES" "$DB_SVC_NAME $STARTED_MSG"
    fi
}

#**************************************************************
# disable the database service
#
#**************************************************************
_stop_db_service() {
    if systemctl is-active --quiet "$DB_SVC_NAME"; then
        log_message "$L_INFO" "$STOP_MSG"
        sudo systemctl stop "$DB_SVC_NAME"
        log_message "$L_SCES" "$DB_SVC_NAME $STOPPED_MSG"
    else
        log_message "$L_INFO" "$DB_SVC_NAME $ALREADY_STOPPED_MSG"
    fi
}

