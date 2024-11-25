#!/bin/bash

# Log file location
LOG_FILE="/var/log/system_monitor.log"

# Ensure the script is run as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root."
    exit 1
fi

# Log system monitoring details
{
    echo "=== System Monitoring - $(date) ==="
    echo "System Uptime:"
    uptime
    echo "Disk Space Usage:"
    df -h
    echo "Memory Usage:"
    free -m
    echo "Logged-in Users:"
    who
    echo "====================================="
} >> "$LOG_FILE"

# Display message
echo "System monitoring details logged to $LOG_FILE."
