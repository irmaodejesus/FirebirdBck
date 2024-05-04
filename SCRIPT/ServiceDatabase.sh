#!/bin/bash

# File log name.
log_file="/var/log/log.ServiceDatabase"
# The name of the service of the database.
service_name="firebird3"

# Function to write log messages
log_message() {
    echo "$(date +"%Y-%m-%d %T") - $1" >> "$log_file"
}

if [ "$1" == "start" ]; then
    # Checks if the service is active, and if it isn't, starts it
    if systemctl is-active --quiet $service_name; then
        log_message "The $service_name service is already started."
    else
        log_message "Starting service...."
        sudo systemctl start $service_name
        log_message "The $service_name service has been started."
    fi
elif [ "$1" == "stop" ]; then
    # Checks if the service is active, and if it is, stops it
    if systemctl is-active --quiet $service_name; then
        log_message "Stopping service...."
        sudo systemctl stop $service_name
        log_message "The $service_name service has been stopped."
    else
        log_message "The $service_name service is already stopped."
    fi
else
    echo "Usage: $0 [start|stop]"
fi