#!/bin/bash

# File log name.
log_file="/var/log/log.FirebirdBck"

# Function to write log messages
log_message() {
    echo "$(date +"%Y-%m-%d %T") - $1" >> "$log_file"
}

log_message " ---> EXEC FirebirdBckMORemRot.sh"

