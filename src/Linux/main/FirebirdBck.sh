# Copyright (c) [2024] [EMMANUEL T. PEIXOTO]
# Licensed under the MIT License. See LICENSE file in the project root for full license information.
# page official of project https://github.com/irmaodejesus/SYSADMIN.FirebirdBck


#!/usr/bin/env bash

_mian(){
# Control Logic
case "$1" in
    mo_rotation)
        log_message "$L_INFO" "$START_MSG"

        ;;
    wk_rotation)
        log_message "$L_INFO" "$START_MSG1"
        ;;
    send_nfs)
        log_message "$L_INFO" "$START_MSG1"
        ;;
    send_sftp)
        log_message "$L_INFO" "$START_MSG1"
        ;;        
    restory_nfs)
        log_message "$L_INFO" "$START_MSG1"
        ;;     
    Setting)
        log_message "$L_INFO" "$START_MSG1"
        ;;                   
    *)
        #log_message "$L_ERRO" " --> Use: $0 mount|umount "
        #show_help
        ;;
esac    
}

_main "$1"

# case um unico banco banco nome

# case semnal totaion
# case daiario no cron sem envio
# case diario no cron envio sftp
# case diario no cron envio scp
