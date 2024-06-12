# Copyright (c) [2024] [EMMANUEL T. PEIXOTO]
# Licensed under the MIT License. See LICENSE file in the project root for full license information.
# page official of project https://github.com/irmaodejesus/SYSADMIN.FirebirdBck


#!/usr/bin/env bash

set -a
######### SYSTEM VAR
# Constants
# Log file name and configuration file defined by environment variables
log_file="${LOG_FILE:-/var/log/log.FirebirdBck}"
CONFIG_FILE="${CONFIG_FILE:-/etc/firebirdbck/FirebirdBck.conf}"



######### PROGRAM MENSSAGE
CONFIG_NOT_FOUND_MSG=" Config File $CONFIG_FILE Not Found!"
EMPTY_VAR_MSG=" The variable '%s' is empty."
MSG_NO_ROOT=" This script must be run as root"
L_ERROR="ERROR "
L_INFO="INFO "
L_SCES="SUCCESS "

MSG_SPACE_NOT_FREE="There is no space available"
MSG_SPACE_FREE="There is space available"
#service start stop
START_MSG=" Starting service...."
STOP_MSG=" Stopping service...."
ALREADY_STARTED_MSG=" The service is already started."
ALREADY_STOPPED_MSG=" The service is already stopped."
STARTED_MSG=" The service has been started."
STOPPED_MSG=" The service has been stopped."

#mount nfs
START_MSG="=====================START MOUNT  ============"
END_MSG="=======END MOUNT ========="
START_MSG1="===================START UNMOUNT ============="
END_MSG1="===================END UNMOUNT ============="

# send nfs
START_MSG="=====================START SEND DAILY BACKUP ============"
STOP_MSG="=====================START SEND DAILY BACKUP ============"

#firebird DB
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

#local rotation
START_MSG="====== GETTING STARTED SAVES SPACE DY LOC======"
STOP_MSG="======== FINISHED SAVES SPACE DY LOC======="

#remote dy rotation

START_MSG="====== GETTING STARTED SAVES SPACE DY REM ======"
STOP_MSG="======== FINISHED SAVES SPACE DY REM ======="


