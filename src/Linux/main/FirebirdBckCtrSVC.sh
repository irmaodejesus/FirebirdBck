# Copyright (c) [2024] [EMMANUEL T. PEIXOTO]
# Licensed under the MIT License. See LICENSE file in the project root for full license information.
# page official of project https://github.com/irmaodejesus/SYSADMIN.FirebirdBck


#!/bin/bash

# Constants
# Log file name and configuration file defined by environment variables
log_file="${LOG_FILE:-/var/log/log.FirebirdBck}"
CONFIG_FILE="${CONFIG_FILE:-/etc/firebirdbck/FirebirdBck.conf}"

CONFIG_NOT_FOUND_MSG=" Config File $CONFIG_FILE Not Found!"
EMPTY_VAR_MSG=" The variable '%s' is empty."
MSG_NO_ROOT=" This script must be run as root"
L_ERROR="ERROR "
L_INFO="INFO "
L_SCES="SUCCESS "

START_MSG=" Starting service...."
STOP_MSG=" Stopping service...."
ALREADY_STARTED_MSG=" The service is already started."
ALREADY_STOPPED_MSG=" The service is already stopped."
STARTED_MSG=" The service has been started."
STOPPED_MSG=" The service has been stopped."

# # Logging Functions
log_message() {
    level="$1"
    message="$2"
    echo "$(date +"%Y-%m-%d %T") - $level - $message" >> "$log_file"
}

log_message  "$L_INFO" " ---> EXEC FirebirdBckCtrSVC.sh"

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
test_empty_var "DB_SVC_NAME"

# Help Function
show_help() {
    echo "$L_ERRO Use: $0 [start|stop]"
    exit 1
}

# Service Control Logic
case "$1" in
    start)
        if systemctl is-active --quiet "$DB_SVC_NAME"; then
            log_message "$L_INFO" "$DB_SVC_NAME $ALREADY_STARTED_MSG"
        else
            log_message "$L_INFO" "$START_MSG"
            sudo systemctl start "$DB_SVC_NAME"
            log_message "$L_SCES" "$DB_SVC_NAME $STARTED_MSG"
        fi
        ;;
    stop)
        if systemctl is-active --quiet "$DB_SVC_NAME"; then
            log_message "$L_INFO" "$STOP_MSG"
            sudo systemctl stop "$DB_SVC_NAME"
            log_message "$L_SCES" "$DB_SVC_NAME $STOPPED_MSG"
        else
            log_message "$L_INFO" "$DB_SVC_NAME $ALREADY_STOPPED_MSG"
        fi
        ;;
    *)
        log_message "$L_ERRO" " --> Use: $0 [start|stop]"
        show_help
        ;;
esac