# Copyright (c) [2024] [EMMANUEL T. PEIXOTO]
# Licensed under the MIT License. See LICENSE file in the project root for full license information.
# page official of project https://github.com/irmaodejesus/SYSADMIN.FirebirdBck


#!/bin/bash

# File log name.
log_file="/var/log/log.FirebirdBck"

# The name of the service of the database.
log_message() {  echo "$(date +"%Y-%m-%d %T") - $1" >> "$log_file" }

log_message " ---> EXEC FirebirdBckNFSMount.sh"

# MSG mount
msg_mount() {   log_message "=====================START MOUNT SHARE FOLD ============"}

# MSG umount
msg_umount() {  log_message "===================START UMOUNT SHARE FOLDER============="}

# Superuser Verification
if [ "$EUID" -ne 0 ]; then
    log_message "This script must be run as root"
    exit 1
fi

# arguments
MOUNT_UMOUNT="$1"

# Set the path to the configuration file
CONFIG_FILE="/etc/firebirdbck/FirebirdBck.conf"

# Verify that the configuration file exists
if [ ! -f "$CONFIG_FILE" ]; then
    log_message "Configuration File $CONFIG_FILE Not Found!"
    exit 1
fi

# Upload the configuration file
source "$CONFIG_FILE"

# Function to test if a variable is empty
test_empty_var() {
    local var_name="$1"
    local var_value="${!var_name}"
    if [ -z "$var_value" ]; then
        log_message "The variable "$var_name" is empty."
        exit 1;
    fi
}

    test_empty_var "MOUNT_POINT"
    test_empty_var "IP_REMOTE_SERVER"
    test_empty_var "SHARE_NFS"

# Help Function
show_help() {
    echo "Use: $0 mount|umount"
    exit 1
}

if [ "$MOUNT_UMOUNT" == "mount" ]; then
    msg_mount
    # Mount the NFS share
    if sudo mount -t nfs "$IP_REMOTE_SERVER:$SHARE_NFS" "$MOUNT_POINT"; then
        log_message "NFS $IP_REMOTE_SERVER:$SHARE_NFS mounted on  $MOUNT_POINT"
        log_message "=======END MOUNT - SUCCESS MOUNT SHARE ========="
        exit 0
    else
        log_message "Failed mount $IP_REMOTE_SERVER:$SHARE_NFS on $MOUNT_POINT"
        log_message "=======END MOUNT - FAILED TO MOUNT SHARE ========="
        exit 1
    fi
elif [ "$MOUNT_UMOUNT" == "umount" ]; then
    msg_umount
    # Unmount the NFS share
    if sudo umount "$MOUNT_POINT"; then
        log_message "NFS share unmounted from $MOUNT_POINT"
        log_message "=======END UMOUNT - SUCCESS UMOUNT SHARE ========="
        exit 0
    else
        log_message "Could not unmount NFS share from $MOUNT_POINT"
        log_message "=======END UMOUNT - FAILED TO UMOUNT SHARE ========="
        exit 1
    fi
else
    log_message "Wrong arguments --> Use: $0 mount|umount "
    show_help
fi