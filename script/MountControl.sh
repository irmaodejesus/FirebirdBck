#!/bin/bash

# File log name.
log_file="/var/log/log.MountControl"
# arguments
mountumount="$1"
localmount="$2"
servershare="$3"


# The name of the service of the database.
log_message() {  echo "$(date +"%Y-%m-%d %T") - $1" >> "$log_file" }

# MSG mount
msg_mount() {   log_message "=====================START MOUNT SHARE FOLD ============"}

# MSG umount
msg_umount() {  log_message "===================START UMOUNT SHARE FOLDER============="}

if [ "$mountumount" == "mount" ]; then
    msg_mount
    
    # Check if the number of arguments is correct.
    if [ $# -ne 3 ]; then
       log_message "Wrong arguments --> Use: $0 mount|umount  /folder/of/mount  ip:/folder/of/share/nfs"
       exit 1
    fi
    
    # mount share NFS in local mount
    sudo mount -t nfs "$servershare" "$localmount"
    
    # check if mounted
    if [ $? -eq 0 ]; then
       log_message "Share NFS mounted of $localmount"
       log_message "=======END MOUNT - SUCESS MOUNT SHARE ========="
       exit 0
    else
       log_message "Don't possible mount NFS share of $localmount"    
       log_message "=======END MOUNT - IMPOSSIBLE MOUNT SHARE ========="
       exit 1
    fi
elif [ "$mountumount1" == "umount" ]; then
    msg_umount

    # Check if the number of arguments is correct.
    if [ $# -ne 2 ]; then
       log_message "Wrong arguments --> Use: $0 mount|umount  /folder/of/mount"
       exit 1
    fi

    # Umount shre folder NFS
    sudo umount "$localmount"

    # check if umounted
    if [ $? -eq 0 ]; then
       log_message "Share NFS mounted of $localmount"
       log_message "=======END UMOUNT - SUCESS UMOUNT SHARE ========="
       exit 0
    else
       log_message "Don't possible mount NFS share of $localmount"    
       log_message "=======END UMOUNT - IMPOSSIBLE UMOUNT SHARE ========="
       exit 1
    fi
else
    log_message "Wrong arguments --> Use: $0 mount|umount  /folder/of/mount  ip:/folder/of/share/nfs"
fi