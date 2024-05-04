#!/bin/bash

#File log name.
log_file="/var/log/log.StartDatabase"
# The name of the service of database to be started.
service_name="firebird3"

# Function to write log messages
log_message() {
    echo "$(date +"%Y-%m-%d %T") - $1" >> "$log_file"
}

# Checks if the service is active, and if it isn't, starts it
if systemctl is-active --quiet $service_name; then
log_message "The $service_name service is already started."
else
    log_message "Starting service...."
    sudo systemctl start $service_name
    log_message "the $service_name service has already been sterted."
    
fi