#!/bin/bash

# Input files
USER_FILE="users.txt"
GROUP_FILE="groups.txt"

# Log file
LOG_FILE="audit.log"

# Ensure the script is run as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root." | tee -a "$LOG_FILE"
    exit 1
fi

# Function to check if a string is valid
is_valid_name() {
    [[ "$1" =~ ^[a-zA-Z0-9._-]+$ ]]
}

# Create users and assign groups
while IFS= read -r user; do
    [[ -z "$user" ]] && continue
    if ! is_valid_name "$user"; then
        echo "Invalid username: $user" | tee -a "$LOG_FILE"
        continue
    fi

    # Add user if not already present
    if ! id "$user" &>/dev/null; then
        useradd "$user"
        echo "User $user created." | tee -a "$LOG_FILE"
    else
        echo "User $user already exists." | tee -a "$LOG_FILE"
    fi

    # Set random password for the user
    PASSWORD=$(openssl rand -base64 12)
    echo "$user:$PASSWORD" | chpasswd
    echo "Password set for $user." | tee -a "$LOG_FILE"

    # Assign groups
    while IFS= read -r group; do
        [[ -z "$group" ]] && continue
        if ! is_valid_name "$group"; then
            echo "Invalid group name: $group" | tee -a "$LOG_FILE"
            continue
        fi

        if ! grep -q "^$group:" /etc/group; then
            groupadd "$group"
            echo "Group $group created." | tee -a "$LOG_FILE"
        fi
        usermod -aG "$group" "$user"
        echo "User $user added to group $group." | tee -a "$LOG_FILE"
    done < "$GROUP_FILE"
done < "$USER_FILE"

echo "User and group setup complete." | tee -a "$LOG_FILE"
