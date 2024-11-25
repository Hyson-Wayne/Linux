#!/bin/bash

# Variables
RESTORE_DIR="/restore_test"
BACKUP_FILE="$1"

# Ensure the script is run as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root."
    exit 1
fi

# Validate the backup file argument
if [[ -z "$BACKUP_FILE" ]]; then
    echo "Usage: $0 <backup_file>"
    exit 1
fi

if [[ ! -f "$BACKUP_FILE" ]]; then
    echo "Backup file $BACKUP_FILE does not exist."
    exit 1
fi

# Create the restore directory if it doesn't exist
echo "Ensuring restore directory exists..."
mkdir -p "$RESTORE_DIR"
if [[ $? -eq 0 ]]; then
    echo "Restore directory verified at $RESTORE_DIR."
else
    echo "Failed to verify/create restore directory."
    exit 1
fi

# Extract the backup file into the restore directory
echo "Restoring backup..."
tar -xzf "$BACKUP_FILE" -C "$RESTORE_DIR"
if [[ $? -eq 0 ]]; then
    echo "Backup restored successfully to $RESTORE_DIR."
else
    echo "Failed to restore backup."
    exit 1
fi
