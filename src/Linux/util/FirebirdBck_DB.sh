# Copyright (c) [2024] [EMMANUEL T. PEIXOTO]
# Licensed under the MIT License. See LICENSE file in the project root for full license information.
# page official of project https://github.com/irmaodejesus/SYSADMIN.FirebirdBck


#!/usr/bin/env bash

# Help Function
show_help() {
    echo "$L_ERROR Use: $0 <Database_Path>"
    exit 1
}

# Function to remove lock file on exit
remove_lock() {
    rm -f "$LOCK_FILE"
}

_backup_DB() {
DTHR=$(date +%d%b%y-%Hh%M)
DIA_DA_SEMANA=$(date +%u)
DB_NAME="$1"
LOCK_FILE="/tmp/FirebirdBckDB.lock"

# Verify that the database parameter has been passed
if [ -z "$1" ]; then
    log_message "$L_ERROR" "$NO_DB"
    show_help
    return 1
fi

# Check if the lock file exists
if [ -e "$LOCK_FILE" ]; then
    log_message "$L_ERROR" "$OTHER_INSTANCE"
    return 1
else
    # Create the lock file
    touch "$LOCK_FILE"
    # Ensure that the lock file will be removed on exit
    trap remove_lock EXIT INT TERM
fi

# Check if the Firebird service has been turned off
if systemctl is-active --quiet "$DB_SVC_NAME"; then
    log_message "$L_ERRO" "$DB_SVC_NAME $RUN_SVCDB"
    log_message "$L_ERRO" "$STOP_BKP"
    exit 1
fi

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
