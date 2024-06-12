# Copyright (c) [2024] [EMMANUEL T. PEIXOTO]
# Licensed under the MIT License. See LICENSE file in the project root for full license information.
# page official of project https://github.com/irmaodejesus/SYSADMIN.FirebirdBck


#!/usr/bin/env bash

#**************************************************************
#  local dy rotation
#
#**************************************************************
_local_dy_rotation(){
# Define the folders that contain the local backups
pastas=("$FOLDER_BKP_LOCAL/day1" "$FOLDER_BKP_LOCAL/day2" "$FOLDER_BKP_LOCAL/day3" "$FOLDER_BKP_LOCAL/day4" "$FOLDER_BKP_LOCAL/day5" "$FOLDER_BKP_LOCAL/day6" "$FOLDER_BKP_LOCAL/day7")
# Get the current day and the previous two days
hoje=$(date +%u)
dia_anterior1=$(( (hoje + 6 - 1) % 7 + 1 ))
dia_anterior2=$(( (hoje + 6 - 2) % 7 + 1 ))
# Keep content from the current day and the previous two days
pastas_a_manter=("$FOLDER_BKP_LOCAL/day$hoje" "$FOLDER_BKP_LOCAL/day$dia_anterior1" "$FOLDER_BKP_LOCAL/day$dia_anterior2")

log_message "$L_INFO" "$START_MSG"

# Check to see if a folder is in the list of folders to keep.
for pasta in "${pastas[@]}"; do
    if [[ " ${pastas_a_manter[*]} " == *" $pasta "* ]]; then
        log_message "$L_INFO" "Content held in $pasta"
    else
        rm -rf "$pasta"/* 
        log_message "$L_SCES" "Deleted content from $pasta"
    fi
done

log_message "$L_INFO" "$STOP_MSG"

}

#**************************************************************
#  remote dy rotation
#
#**************************************************************
_remote_dy_rotation(){

# Define the folders that contain the local backups
pastas=("$MOUNT_POINT/firebirdbck/day1" "$MOUNT_POINT/firebirdbck/day2" "$MOUNT_POINT/firebirdbck/day3" "$MOUNT_POINT/firebirdbck/day4" "$MOUNT_POINT/firebirdbck/day5" "$MOUNT_POINT/firebirdbck/day6" "$MOUNT_POINT/firebirdbck/day7")
# Get the current day and the previous two days
hoje=$(date +%u)
dia_anterior1=$(( (hoje + 6 - 1) % 7 + 1 ))
dia_anterior2=$(( (hoje + 6 - 2) % 7 + 1 ))
# Keep content from the current day and the previous two days
pastas_a_manter=("$MOUNT_POINT/firebirdbck/day$hoje" "$MOUNT_POINT/firebirdbck/day$dia_anterior1" "$MOUNT_POINT/firebirdbck/day$dia_anterior2")

log_message "$L_INFO" "$START_MSG"

# Check to see if a folder is in the list of folders to keep.
for pasta in "${pastas[@]}"; do
    if [[ " ${pastas_a_manter[*]} " == *" $pasta "* ]]; then
        log_message "$L_INFO" "Content held in $pasta"
    else
        rm -rf "$pasta"/* 
        log_message "$L_SCES" "Deleted content from $pasta"
    fi
done

log_message "$L_INFO" "$STOP_MSG"
}    

#**************************************************************
#  remote MO rotation
#
#**************************************************************
_remote_MO_rotation(){

}

#**************************************************************
#  remote WK rotation
#
#**************************************************************
_remote_WK_rotation(){

}
