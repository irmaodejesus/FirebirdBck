# Copyright (c) [2024] [EMMANUEL T. PEIXOTO]
# Licensed under the MIT License. See LICENSE file in the project root for full license information.
# page official of project https://github.com/irmaodejesus/SYSADMIN.FirebirdBck


#!/bin/bash

# Constants
LOG_FILE="/var/log/log.FirebirdBck"
CONFIG_FILE="/etc/firebirdbck/FirebirdBck.conf"
START_MSG="Starting service...."
STOP_MSG="Stopping service...."
ALREADY_STARTED_MSG="The service is already started."
ALREADY_STOPPED_MSG="The service is already stopped."
STARTED_MSG="The service has been started."
STOPPED_MSG="The service has been stopped."
CONFIG_NOT_FOUND_MSG="Config File $CONFIG_FILE Not Found!"
EMPTY_VAR_MSG="The variable '%s' is empty."

# Logging Functions
log_message() {
    echo "$(date +"%Y-%m-%d %T") - $1" >> "$LOG_FILE"
}

log_message " ---> EXEC FirebirdBckCtrSVC.sh"

# Superuser Verification
if [ "$EUID" -ne 0 ]; then
    log_message "This script must be run as root"
    exit 1
fi

# Check if the config file exists
if [ ! -f "$CONFIG_FILE" ]; then
    log_message "$CONFIG_NOT_FOUND_MSG"
    exit 1
fi

# Upload the configuration file
source "$CONFIG_FILE"

# Function to test if a variable is empty
test_empty_var() {
    local var_name="$1"
    local var_value="${!var_name}"
    if [ -z "$var_value" ]; then
        log_message "$(printf "$EMPTY_VAR_MSG" "$var_name")"
        exit 1
    fi
}

# Checking the required variable
test_empty_var "DB_SVC_NAME"

# Help Function
show_help() {
    echo "Use: $0 [start|stop]"
    exit 1
}

# Service Control Logic
case "$1" in
    start)
        if systemctl is-active --quiet "$DB_SVC_NAME"; then
            log_message "$DB_SVC_NAME $ALREADY_STARTED_MSG"
        else
            log_message "$START_MSG"
            sudo systemctl start "$DB_SVC_NAME"
            log_message "$DB_SVC_NAME $STARTED_MSG"
        fi
        ;;
    stop)
        if systemctl is-active --quiet "$DB_SVC_NAME"; then
            log_message "$STOP_MSG"
            sudo systemctl stop "$DB_SVC_NAME"
            log_message "$DB_SVC_NAME $STOPPED_MSG"
        else
            log_message "$DB_SVC_NAME $ALREADY_STOPPED_MSG"
        fi
        ;;
    *)
        log_message "Wrong argument --> Use: $0 [start|stop]"
        show_help
        ;;
esac