
# **<span style="color:green">System Monitoring Script</span>**

## **<span style="color:green">Explanation</span>**

---

### **<span style="color:blue">1. Root Check</span>**

```bash
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root."
    exit 1
fi
```

- Ensures the script is run as root to avoid permission issues when accessing system details or writing logs.

---

### **<span style="color:blue">2. Log File Location</span>**

```bash
LOG_FILE="/var/log/system_monitor.log"
```

- Defines the location where the script logs monitoring data. The `/var/log` directory is typically used for log files.

---

### **<span style="color:blue">3. System Monitoring Commands</span>**

```bash
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
```

- Logs key system metrics:
  - **Uptime**: Shows how long the system has been running.
  - **Disk Space Usage**: Displays available disk space in a human-readable format.
  - **Memory Usage**: Shows memory usage in megabytes.
  - **Logged-in Users**: Lists all currently logged-in users.
- Appends (`>>`) the details to the log file with a timestamp.

---

### **<span style="color:blue">4. Message Display</span>**

```bash
echo "System monitoring details logged to $LOG_FILE."
```

- Confirms successful execution of the script.

---

## **<span style="color:green">Setting Up Cron Job</span>**

### **<span style="color:blue">1. Install Cron (for Amazon Linux or RedHat-based systems)</span>**

```bash
sudo yum install -y cronie
```

---

### **<span style="color:blue">2. Start and Enable the Cron Service</span>**

```bash
sudo systemctl start crond
sudo systemctl enable crond
```

---

### **<span style="color:blue">3. Verify Installation</span>**

- Check if `crontab` is now available:

```bash
crontab -V
```

  - Expected output: `crontab (vixie-cron) version x.x.x`.

---

### **<span style="color:blue">4. Edit and Schedule Cron Job</span>**

- Open the crontab editor:

```bash
crontab -e
```

  - This opens the crontab file for editing.
  - Add the following line to schedule the script every hour:

```bash
0 * * * * /path/to/system_monitor.sh
```
  - Example:
  
```bash
0 * * * * /home/ec2-user/project_3/system_monitor.sh
```

- Schedules the script to run every hour.
- Explanation of the cron format:
  ```plaintext
  ┌───────────── minute (0 - 59)
  │ ┌───────────── hour (0 - 23)
  │ │ ┌───────────── day of the month (1 - 31)
  │ │ │ ┌───────────── month (1 - 12)
  │ │ │ │ ┌───────────── day of the week (0 - 7, where both 0 and 7 mean Sunday)
  │ │ │ │ │
  │ │ │ │ │
  0 * * * * command_to_execute
  ```

---

### **<span style="color:blue">5. Save and Exit</span>**

- Save the changes to schedule the cron job.

---

## **<span style="color:green">Execution Steps</span>**

### **<span style="color:blue">1. Save the Script</span>**

- Save the script as `system_monitor.sh`.

---

### **<span style="color:blue">2. Make It Executable</span>**

```bash
sudo chmod +x system_monitor.sh
```

---

### **<span style="color:blue">3. Run Manually (Optional)</span>**

- Test the script manually before scheduling:

```bash
sudo bash system_monitor.sh
```

---

### **<span style="color:blue">4. Check Logs</span>**

- View the log file to verify the script's output:

```bash
sudo cat /var/log/system_monitor.log
```

---

## **<span style="color:green">Expected Results</span>**

### **<span style="color:blue">1. Log File Output (/var/log/system_monitor.log)</span>**

Each run adds a new entry to the log file:

```plaintext
=== System Monitoring - Mon Nov 22 14:00:00 UTC 2024 ===
System Uptime:
 14:00:00 up 10 days,  4:23,  2 users,  load average: 0.03, 0.01, 0.00
Disk Space Usage:
Filesystem      Size  Used Avail Use% Mounted on
/dev/xvda1       20G  5.4G   15G  27% /
Memory Usage:
             total        used        free      shared  buff/cache   available
Mem:           2000         500        1200          50         300        1400
Logged-in Users:
ec2-user pts/0 2024-11-22 12:00 (172.31.0.1)
```

### **<span style="color:blue">2. Cron Job Execution</span>**

- The script runs automatically every hour and updates the log file.
