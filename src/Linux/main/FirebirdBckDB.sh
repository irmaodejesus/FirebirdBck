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

START_BKP="===================== START BACKUP ============"
STOP_BKP="===================== END BACKUP ============"
OTHER_INSTANCE="Another instance of the script is already running."
NO_DB="Database parameter not provided."
RUN_SCP="Running the script on the day"
DEL_FILE="Deleting files from the folder"
INIT_BKP="Initiating backup"
COMPRES="Compress Backup"
INIT_BCK_F="Remove Initial Backup File"
RUN_SVCDB="service is running. Unable to perform backup"

LOCK_FILE="/tmp/FirebirdBckDB.lock"
DTHR=$(date +%d%b%y-%Hh%M)
DIA_DA_SEMANA=$(date +%u)
DB_NAME="$1"

# # Logging Functions
log_message() {
    level="$1"
    message="$2"
    echo "$(date +"%Y-%m-%d %T") - $level - $message" >> "$log_file"
}

log_message  "$L_INFO" " ---> EXEC FirebirdBckDB.sh"

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
test_empty_var "FOLDER_BKP_LOCAL"

# Help Function
show_help() {
    echo "$L_ERROR Use: $0 <Database_Path>"
    exit 1
}

# Verify that the database parameter has been passed
if [ -z "$1" ]; then
    log_message "$L_ERROR" "$NO_DB"
    show_help
fi

# Function to remove lock file on exit
remove_lock() {
    rm -f "$LOCK_FILE"
}

# Check if the lock file exists
if [ -e "$LOCK_FILE" ]; then
    log_message "$L_ERROR" "$OTHER_INSTANCE"
    exit 1
else
    # Create the lock file
    touch "$LOCK_FILE"
    # Ensure that the lock file will be removed on exit
    trap remove_lock EXIT INT TERM
fi

# Backup Function
backup_db() {
    local backup_day="$FOLDER_BKP_LOCAL/day$DIA_DA_SEMANA/"
    local name_=$(basename "$DB_NAME")
    log_message "$L_INFO" "$RUN_SCP $DIA_DA_SEMANA..."

    # Delete old files
    rm -f "$backup_day"/*
    log_message "$L_SCES" "$DEL_FILE $backup_day..."

    # Start Backup
    gbak -backup -v -ignore -garbage -limbo "$DB_NAME" "$backup_day/$name_.$DTHR.fbk"
    log_message "$L_SCES" "$INIT_BKP $DB_NAME..."

    # Compress Backup
    tar -czf "$backup_day/$name_.$DTHR.fbk.tar.gz" "$backup_day/$name_.$DTHR.fbk"
    log_message "$L_SCES" "$COMPRES $backup_day/$name_.$DTHR.fbk ..."

    # Remove Initial Backup File    
    rm -f "$backup_day/$name_.$DTHR.fbk"
    log_message "$L_SCES" "$INIT_BCK_F $backup_day/$name_.$DTHR.fbk ..."

    # Encrypt backup

    # Backup Termination
    log_message "$L_SCES" "$STOP_BKP"
}

# Start of backup
log_message "$L_INFO" "$START_BKP"

# Check if the Firebird service has been turned off
if systemctl is-active --quiet "$DB_SVC_NAME"; then
    log_message "$L_ERRO" "$DB_SVC_NAME $RUN_SVCDB"
    log_message "$L_ERRO" "$STOP_BKP"
    exit 1
fi

# Perform backup
backup_db
