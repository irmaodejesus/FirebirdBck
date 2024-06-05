# Copyright (c) [2024] [EMMANUEL T. PEIXOTO]
# Licensed under the MIT License. See LICENSE file in the project root for full license information.
# page official of project https://github.com/irmaodejesus/SYSADMIN.FirebirdBck


#!/bin/bash

# Constants
LOG_FILE="/var/log/log.FirebirdBck"
CONFIG_FILE="/etc/firebirdbck/FirebirdBck.conf"
LOCK_FILE="/tmp/FirebirdBckDB.lock"
DTHR=$(date +%d%b%y-%Hh%M)
DIA_DA_SEMANA=$(date +%u)
START_BKP="===================== START BACKUP ============"
STOP_BKP="===================== END BACKUP ============"
DB_NAME="$1"

# Logging Functions
log_message() {
    echo "$(date +"%Y-%m-%d %T") - $1" >> "$LOG_FILE"
}

# Help Function
show_help() {
    echo "Use: $0 <Database_Path>"
    exit 1
}

log_message " ---> EXEC FirebirdBckDB.sh"

# Superuser Verification
if [ "$EUID" -ne 0 ]; then
    log_message "This script must be run as root"
    exit 1
fi

# Verify that the configuration file exists
if [ ! -f "$CONFIG_FILE" ]; then
    log_message "Config File $CONFIG_FILE Not Found!"
    exit 1
fi

# Upload the configuration file
source "$CONFIG_FILE"

# Function to test if a variable is empty
test_empty_var() {
    local var_name="$1"
    local var_value="${!var_name}"
    if [ -z "$var_value" ]; then
        log_message "The variable '$var_name' is empty."
        exit 1
    fi
}

# Checking the required variable
test_empty_var "DB_SVC_NAME"
test_empty_var "FOLDER_BKP_LOCAL"

# Verify that the database parameter has been passed
if [ -z "$1" ]; then
    log_message "Database parameter not provided."
    show_help
fi

# Function to remove lock file on exit
remove_lock() {
    rm -f "$LOCK_FILE"
}

# Check if the lock file exists
if [ -e "$LOCK_FILE" ]; then
    log_message "Another instance of the script is already running."
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
    log_message "Running the script on the day $DIA_DA_SEMANA..."

    # Delete old files
    log_message "Deleting files from the folder $backup_day..."
    rm -f "$backup_day"/*

    # Start Backup
    log_message "Initiating backup $DB_NAME..."
    gbak -backup -v -ignore -garbage -limbo "$DB_NAME" "$backup_day/$name_.$DTHR.fbk"

    # Compress Backup
    log_message "Compress Backup $backup_day/$name_.$DTHR.fbk ..."
    tar -czf "$backup_day/$name_.$DTHR.fbk.tar.gz" "$backup_day/$name_.$DTHR.fbk"

    # Remove Initial Backup File
    log_message "Remove Backup File $backup_day/$name_.$DTHR.fbk ..."
    rm -f "$backup_day/$name_.$DTHR.fbk"

    # Encrypt backup
}

# Start of backup
log_message "$START_BKP"

# Check if the Firebird service has been turned off
if systemctl is-active --quiet "$DB_SVC_NAME"; then
    log_message "ERROR: The $DB_SVC_NAME service is running. Unable to perform backup."
    log_message "$STOP_BKP"
    exit 1
fi

# Perform backup
backup_db

# Backup Termination
log_message "$STOP_BKP"