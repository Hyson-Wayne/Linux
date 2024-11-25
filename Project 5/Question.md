# Project 5: Data Backup and Restoration Automation

## Objective
Automate the backup and restoration of critical system files.

## Tasks
1. **Backup Automation (backup.sh):**
   - Compress the `/etc` directory into a timestamped `.tar.gz` file (e.g., `backup_YYYYMMDD.tar.gz`).
   - Move the backup file to a specific directory (e.g., `/backup`).
   - Verify the integrity of the backup file.

2. **Restore Automation (restore.sh):**
   - Extract a backup file into a test directory (e.g., `/restore_test`).
   - Verify that the restored files match the original structure.

3. **Schedule Automation:**
   - Schedule the backup script to run daily at midnight using a cron job.

## Deliverables
- The `backup.sh` script.
- The `restore.sh` script.
- The cron job configuration.
- A sample backup file and verification steps.

## Expected Results
1. A compressed backup file (e.g., `etc_backup_<TIMESTAMP>.tar.gz`) is created in `/backup`.
2. The backup file can be restored into `/restore_test`, maintaining the `/etc` directory structure.
