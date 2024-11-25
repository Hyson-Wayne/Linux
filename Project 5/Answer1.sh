#!/bin/bash

# Variables
BACKUP_DIR="/backup"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_FILE="$BACKUP_DIR/etc_backup_$TIMESTAMP.tar.gz"

# Ensure the script is run as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root."
    exit 1
fi

# Create the backup directory if it doesn't exist
echo "Ensuring backup directory exists..."
mkdir -p "$BACKUP_DIR"
if [[ $? -eq 0 ]]; then
    echo "Backup directory verified at $BACKUP_DIR."
else
    echo "Failed to verify/create backup directory."
    exit 1
fi

# Create a compressed backup of the /etc directory
echo "Creating backup of /etc directory..."
tar -czf "$BACKUP_FILE" /etc
if [[ $? -eq 0 ]]; then
    echo "Backup created successfully: $BACKUP_FILE"
else
    echo "Failed to create backup."
    exit 1
fi

# Verify the backup file
echo "Verifying the backup file..."
tar -tzf "$BACKUP_FILE" > /dev/null
if [[ $? -eq 0 ]]; then
    echo "Backup integrity verified successfully."
else
    echo "Backup integrity verification failed."
    exit 1
fi
