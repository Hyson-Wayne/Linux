
# **Backup Script (backup.sh)**

## **Variables:**
- **BACKUP_DIR**: Directory where backup files are stored.
- **TIMESTAMP**: Adds a timestamp to the backup file name for uniqueness.
- **BACKUP_FILE**: Full path to the compressed .tar.gz backup file.

---

## **Root Check:**
```bash
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root."
    exit 1
fi
```
- Ensures the script runs with administrative privileges, required for accessing `/etc` and creating files in `/backup`.

---

## **Backup Directory Creation:**
```bash
mkdir -p "$BACKUP_DIR"
```
- Creates the backup directory if it doesn’t exist.
- The `-p` option prevents errors if the directory already exists.

---

## **Backup Creation:**
```bash
tar -czf "$BACKUP_FILE" /etc
```
- Compresses the `/etc` directory into a `.tar.gz` file.
- Stores the backup in the `BACKUP_DIR` with a timestamped filename.

---

# **Restore Script (restore.sh)**

## **Variables:**
- **RESTORE_DIR**: Directory where the backup will be extracted.
- **BACKUP_FILE**: First script argument (`$1`) specifying the backup file to restore.

---

## **Root Check:**
Same as in the backup script.

---

## **Backup File Validation:**
```bash
if [[ ! -f "$BACKUP_FILE" ]]; then
    echo "Backup file $BACKUP_FILE does not exist."
    exit 1
fi
```
- Ensures the specified backup file exists before proceeding.

---

## **Restore Directory Creation:**
```bash
mkdir -p "$RESTORE_DIR"
```
- Creates the directory where the backup will be restored.

---

## **Restore Backup:**
```bash
tar -xzf "$BACKUP_FILE" -C "$RESTORE_DIR"
```
- Extracts the backup file contents into the restore directory.

---

# **Cron Job for Scheduled Backup**

To automate the backup process, schedule the `backup.sh` script to run daily at midnight:

## **Steps:**

1. **Open the cron editor:**
```bash
crontab -e
```

2. **Add the following line:**
```bash
0 0 * * * /path/to/backup.sh
```

---

# **Execution Steps**

## **1. Backup:**
- Run the backup script manually or let it run via the cron job:
```bash
sudo bash backup.sh
```
- Verify the backup file:
```bash
ls /backup
```

---

## **2. Restore:**
- Specify the backup file to restore:
```bash
sudo bash restore.sh /backup/etc_backup_<TIMESTAMP>.tar.gz
```
- Verify the restored contents:
```bash
ls /restore_test/etc
```

---

# **Expected Results**

## **1. Backup File:**
- A timestamped backup file is created in `/backup`:
```bash
/backup/etc_backup_20241122_140000.tar.gz
```

## **2. Restore Output:**
- The `/restore_test` directory contains the restored `/etc` structure:
```bash
/restore_test/etc/...
```
