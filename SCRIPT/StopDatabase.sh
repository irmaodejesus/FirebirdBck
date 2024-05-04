#!/bin/bash
#File log name.
log_file="/var/log/log.StopDatabase"
# The name of the service of database to be stoped.
service_name="firebird3"

# Function to write log messages
log_message() {
    echo "$(date +"%Y-%m-%d %T") - $1" >> "$log_file"
}

# Checks if the service is active, and if it is, stops it.
if systemctl is-active --quiet $service_name; then
    log_message "Stopping service...."
    sudo systemctl start $service_name
    log_message "the $service_name service has already been stopped."
else
    log_message "The $service_name service is already stopped."
fi