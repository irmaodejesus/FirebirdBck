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

START_MSG="=====================START MOUNT  ============"
END_MSG="=======END MOUNT ========="
START_MSG1="===================START UNMOUNT ============="
END_MSG1="===================END UNMOUNT ============="

#  Logging Functions
log_message() {
    level="$1"
    message="$2"
    echo "$(date +"%Y-%m-%d %T") - $level - $message" >> "$log_file"
}

log_message "$L_INFO" " ---> EXEC FirebirdBckNFSMount.sh"

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
test_empty_var "IP_REMOTE_SERVER"
test_empty_var "SHARE_NFS"

# Help Function
show_help() {
    echo "$L_ERRO Use: $0 mount|umount"
    exit 1
}

# mount Control Logic
case "$1" in
    mount)
        log_message "$L_INFO" "$START_MSG"
        # Mount the NFS share
        if sudo mount -t nfs "$IP_REMOTE_SERVER:$SHARE_NFS" "$MOUNT_POINT"; then
            log_message "$L_INFO" "$IP_REMOTE_SERVER:$SHARE_NFS $L_SCES  $MOUNT_POINT"
            log_message "$L_SCES" "$END_MSG"
        else
            log_message "$L_ERRO" "$IP_REMOTE_SERVER:$SHARE_NFS $L_ERRO $MOUNT_POINT"
            log_message "$L_ERRO" "$END_MSG"
            exit 1        
        fi
        ;;
    umount)
        log_message "$L_INFO" "$START_MSG1"
        # Unmount the NFS share
        if sudo umount "$MOUNT_POINT"; then
            log_message "$L_INFO" " $L_SCES $MOUNT_POINT"
            log_message "$L_SCES" "$END_MSG1"
        else
            log_message "$L_ERRO" " $MOUNT_POINT"
            log_message "$L_ERRO" "$END_MSG1"
            exit 1
        fi  
        ;;
    *)
        log_message "$L_ERRO" " --> Use: $0 mount|umount "
        show_help
        ;;
esac        