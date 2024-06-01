# Copyright (c) [2024] [EMMANUEL T. PEIXOTO]
# Licensed under the MIT License. See LICENSE file in the project root for full license information.
# page official of project https://github.com/irmaodejesus/SYSADMIN.FirebirdBck


#!/bin/bash

# File log name.
log_file="/var/log/log.FirebirdBck"

# Function to write log messages
log_message() {
    echo "$(date +"%Y-%m-%d %T") - $1" >> "$log_file"
}

log_message " ---> EXEC FirebirdBckWKRemRot.sh"

