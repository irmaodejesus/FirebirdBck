# Copyright (c) [2024] [EMMANUEL T. PEIXOTO]
# Licensed under the MIT License. See LICENSE file in the project root for full license information.
# page official of project https://github.com/irmaodejesus/SYSADMIN.FirebirdBck


#!/usr/bin/env bash


#**************************************************************
# Mount the NFS share
#
#**************************************************************
_mount_remote_nfs_share() { 
    log_message "$L_INFO" "$START_MSG"
    
    if sudo mount -t nfs "$IP_REMOTE_SERVER:$SHARE_NFS" "$MOUNT_POINT"; then
        log_message "$L_INFO" "$IP_REMOTE_SERVER:$SHARE_NFS $L_SCES  $MOUNT_POINT"
        log_message "$L_SCES" "$END_MSG"
        return 0
    else
        log_message "$L_ERRO" "$IP_REMOTE_SERVER:$SHARE_NFS $L_ERRO $MOUNT_POINT"
        log_message "$L_ERRO" "$END_MSG"
        return 1        
    fi
}

#**************************************************************
# Unmount the NFS share
#
#**************************************************************
_unmount_remote_nfs_share() { 
    log_message "$L_INFO" "$START_MSG1"

    if sudo umount "$MOUNT_POINT"; then
        log_message "$L_INFO" " $L_SCES $MOUNT_POINT"
        log_message "$L_SCES" "$END_MSG1"
        return 0
    else
        log_message "$L_ERRO" " $MOUNT_POINT"
        log_message "$L_ERRO" "$END_MSG1"
        return 1
    fi 
}       

#**************************************************************
# Reurn the day of the week (1 to 7, where 1 is Monday and 7 is Sunday).
#
#**************************************************************
_wk_day() {
    return date +%u
}

#**************************************************************
# verify that an NFS share is mounted
#
#**************************************************************
_remote_is_moounted() {
    
    local share_nfs="$IP_REMOTE_SERVER:$SHARE_NFS"

    if mount | grep -q "$cshare_nfs"; thenn
        log_message "$L_INFO" "$share_nfs mounted."
        return 0   
    else
        log_message "$L_ERRO" "$share_nfs NOT mounted."
        return 1
    fi
}

#**************************************************************
#  Verify that all folders exist and create them
#
#**************************************************************
_remote_base_folders() {
    local base_name="$MOUNT_POINT/firebirdbck/day"
    local total_folders=7

    for ((i=1; i<=total_folders; i++)); do
        local teste_pasta="${base_name}${i}"

        if [ ! -d "$teste_pasta" ]; then
            log_message  "$L_INFO" "The $teste_pasta does not exist."
            sudo mkdir -p $teste_pasta
            log_message  "$L_INFO" "Folder created"            
        fi
    done
}


#**************************************************************
#  CHECK IF THE ORIGIN FOLDER IS EMPTY.
#
#**************************************************************
_is_empty_folder () {
    local folder_check="$1"
    
    #test if folder_check is empity

}

#**************************************************************
#  compares whether two folders are identical
#
#**************************************************************
_compare_folder () {
    local folder_source="$1"
    local folder_destination="$2"
    
    #test folder_source==folder_destination
}

#**************************************************************
#  send backup to remote NFS folder
#
#**************************************************************
_send_back_remote_nfs_dy () {
    local dy_wk=$(date +%u)
    # Backup local  folder
    local folder_source="$FOLDER_BKP_LOCAL/day$dy_wk"
    # CHECK IF THE ORIGIN FOLDER IS EMPTY.
    # _is_empty_folder folder_source
    # destination folder 
    folder_remote="$MOUNT_POINT/firebirdbck/day$dy_wk"
    # CHECKING AVAILABLE SPACE (_util)
    # _minimum_free_size folder_remote

    log_message "$L_INFO" "$START_MSG"

    # 1st deleted content of remote folder refer this day of before backup
    sudo rm -Rf "$folder_remote"/*
    log_message "$L_SCES" "Content deleted $folder_remote/* "

    # Copy the local folder to the folder corresponding to the day
    sudo cp -Rf "$folder_source"/* "$folder_remote"/
    log_message "$L_SCES" "Backup copied to $folder_remote"

    # CHECK COPY INTEGRITY
    # _compare_folder folder_source folder_remote
    log_message "$L_SCES" "$STOP_MSG"
}


#**************************************************************
#  send backup to remote SFTP folder
#
#**************************************************************
_send_back_remote_sftp_dy () {
    local folder_source="$1"
    local folder_remote="$2"
    
    #send folder_source to folder_remote
}
