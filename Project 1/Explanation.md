
# Project 1: Automated User and Group Management System

## Explanation

### 1. Script Files and Purpose

- **`USER_FILE="users.txt"`**: This file contains a list of usernames, one per line. For example:
    ```txt
    alice
    bob
    charlie
    ```
- **`GROUP_FILE="groups.txt"`**: This file contains a list of group names, one per line. For example:
    ```txt
    developers
    testers
    ```
- **`LOG_FILE="audit.log"`**: This file logs all actions and errors performed by the script. It provides a traceable record of all user and group management actions.

### 2. Root Privilege Check

The script ensures that it is executed with administrative (root) privileges. This is necessary because creating users and modifying groups requires root access.

The root check is done using the following snippet:

```bash
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root." | tee -a "$LOG_FILE"
    exit 1
fi
```

If the script is not run as root, it outputs an error message and stops execution.

### 3. Validation Function for Names

The script contains a function, `is_valid_name()`, to ensure that the user and group names follow a valid format. This function checks that the names contain only letters, numbers, periods, hyphens, or underscores.

```bash
is_valid_name() {
    [[ "$1" =~ ^[a-zA-Z0-9._-]+$ ]]
}
```

- The regular expression `^[a-zA-Z0-9._-]+$` allows the characters: letters (uppercase and lowercase), numbers, periods, hyphens, and underscores.
- Invalid usernames or group names will be skipped, and a warning will be logged.

### 4. User Creation and Password Assignment

The script reads usernames from `users.txt` and creates them if they do not already exist. If a username already exists, it will be skipped, and the script logs this action.

For each new user, the script generates a secure random password using OpenSSL. The password is set using the `chpasswd` command:

```bash
PASSWORD=$(openssl rand -base64 12)
echo "$user:$PASSWORD" | chpasswd
```

- **`openssl rand -base64 12`** generates a random, secure 12-character password.
- **`chpasswd`** is used to securely assign the generated password to the user.

### 5. Group Creation and Assignment

The script then assigns each user to groups specified in `groups.txt`. It performs the following tasks for each group:

1. Reads group names from `groups.txt`.
2. Skips any blank or invalid group names.
3. If the group doesn't already exist, it creates the group using the `groupadd` command.
4. Adds the user to the group using `usermod`.

Here’s the relevant section of the script:

```bash
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
```

- **`usermod -aG "$group" "$user"`** adds the user to the specified group.

### 6. Logging

All actions performed by the script are logged into `audit.log` using the `tee` command, which ensures the output is both displayed on the screen and written to the log file.

Here’s an example of how an action is logged:

```bash
echo "User $user added to group $group." | tee -a "$LOG_FILE"
```

This ensures that you have a complete, traceable record of all user and group management operations.

### 7. Execution Steps

1. Place `users.txt` and `groups.txt` in the same directory as the script.
2. Run the script:
    ```bash
    sudo bash user_group_manager.sh
    ```
3. Review the `audit.log` file for detailed logs of the script’s execution.

### Sample Input Files

#### `users.txt`
```txt
alice
bob
charlie
```

#### `groups.txt`
```txt
developers
testers
```

### Output

- Users created: `alice`, `bob`, `charlie`.
- Groups created: `developers`, `testers`.
- Logs recorded in `audit.log`.

---
