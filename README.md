
# Linux Automation Scripts

---

## **<span style="color:green">Contact Information</span>**

For further assistance or inquiries, click the buttons below:

- [![Name](https://img.shields.io/badge/Name-Nditafon%20Hyson%20Nuigho-brightgreen)](mailto:nditafonhysonn@gmail.com)
- [![Phone](https://img.shields.io/badge/Phone-%2B237679638540-brightgreen)](tel:+237679638540)
- [![Email](https://img.shields.io/badge/Email-nditafonhysonn%40gmail.com-blue)](mailto:nditafonhysonn@gmail.com)
- [![GitHub](https://img.shields.io/badge/GitHub-Hyson--Wayne-lightgrey?logo=github)](https://github.com/Hyson-Wayne)
- [![LinkedIn](https://img.shields.io/badge/LinkedIn-nditafon--hyson-blue?logo=linkedin)](https://www.linkedin.com/in/nditafon-hyson-762a6623b/)

---

This repository contains various shell scripts designed to automate system administration tasks on a Linux environment. These projects cover tasks like user and group management, application deployment, system monitoring, backup, and restoration. Each project is organized in its own directory, containing the question, answer, and explanation for clarity.

## Definitions

### Linux
Linux is a popular, open-source operating system kernel that is widely used in servers, desktops, and embedded systems. It is known for its stability, security, and flexibility. Many Linux distributions (such as Ubuntu, CentOS, Amazon Linux) are built around the Linux kernel and are used for a wide variety of purposes, from web servers to development environments.

### Scripting
Scripting refers to writing a sequence of commands in a programming language to automate tasks. In the context of Linux, shell scripting is commonly used to write scripts in the Bash shell (or other shells like Zsh, Fish) to automate system administration tasks like file manipulation, user management, process control, and more.

## Projects Overview

### 1. Project 1: Automated User and Group Management System
**Objective:** Automate the creation, modification, and verification of user accounts and groups using shell scripting.

**Script:** `user_group_manager.sh`

**Tasks:**
- Create users and assign them to specific groups.
- Set unique passwords for each user.
- Grant sudo privileges to selected users.
- Log actions to `audit.log`.

**Files:** `users.txt`, `groups.txt`, `audit.log`

**Directory Structure:**
```
/project1
├── question.md
├── answer.sh
└── explanation.md
```

---

### 2. Project 2: Apache HTTP Server Deployment and Customization
**Objective:** Deploy an Apache HTTP server on an Amazon EC2 instance and customize its content using shell scripting.

**Script:** `deploy_apache.sh`

**Tasks:**
- Install Apache.
- Create custom directories under `/var/www/html/`.
- Add HTML content to directories.
- Verify the server setup via browser.

**Files:** `index.html`, etc.

**Directory Structure:**
```
/project2
├── question.md
├── answer.sh
└── explanation.md
```

---

### 3. Project 3: System Monitoring with Cron Jobs
**Objective:** Automate system monitoring tasks such as uptime, disk space, memory usage, and logging via cron jobs.

**Script:** `system_monitor.sh`

**Tasks:**
- Log system stats into a log file every hour.
- Set up cron jobs for periodic execution.

**Directory Structure:**
```
/project3
├── question.md
├── answer.sh
└── explanation.md
```

---

### 4. Project 4: Deployment of a Custom Java Application
**Objective:** Deploy and execute a simple Java application using shell scripting.

**Script:** `deploy_app.sh`

**Tasks:**
- Create a deployment directory.
- Compile and run a Java program (`app.java`).
- Log the output to `app_output.log`.

**Directory Structure:**
```
/project4
├── question.md
├── answer.sh
└── explanation.md
```

---

### 5. Project 5: Data Backup and Restoration Automation
**Objective:** Automate the backup and restoration of critical system files.

**Scripts:** `backup.sh`, `restore.sh`

**Tasks:**
- Backup `/etc` directory into a timestamped `.tar.gz` file.
- Restore backup to a test directory.
- Schedule the backup to run daily via cron.

**Directory Structure:**
```
/project5
├── question.md
├── answer.sh
└── explanation.md
```

## Directory Structure

```
/linux-automation-scripts
│
├── project1                       # Automated User and Group Management System
│   ├── question.md
│   ├── answer.sh
│   └── explanation.md
│
├── project2                       # Apache HTTP Server Deployment and Customization
│   ├── question.md
│   ├── answer.sh
│   └── explanation.md
│
├── project3                       # System Monitoring with Cron Jobs
│   ├── question.md
│   ├── answer.sh
│   └── explanation.md
│
├── project4                       # Deployment of a Custom Java Application
│   ├── question.md
│   ├── answer.sh
│   └── explanation.md
│
├── project5                       # Data Backup and Restoration Automation
│   ├── question.md
│   ├── answer.sh
│   └── explanation.md
│
├── README.md                     # This file
```

## Prerequisites
- **Operating System:** Linux (Ubuntu, CentOS, Amazon Linux, or similar)
- **Software:**
  - Apache HTTP Server (for Project 2)
  - Java Development Kit (JDK) (for Project 4)
  - Cron (for scheduling tasks in Project 3 and Project 5)

## Setup Instructions

### 1. Clone the Repository:
Clone this repository to your local or EC2 instance:

```bash
git clone <repository_url>
cd linux-automation-scripts
```

### 2. Make Scripts Executable:
After downloading the scripts, give them execution permissions:

```bash
chmod +x project1/user_group_manager.sh project2/deploy_apache.sh project3/system_monitor.sh project4/deploy_app.sh project5/backup.sh project5/restore.sh
```

### 3. Run the Scripts:
To run any script, execute it using bash:

```bash
sudo bash project1/user_group_manager.sh
sudo bash project2/deploy_apache.sh
sudo bash project3/system_monitor.sh
sudo bash project4/deploy_app.sh
sudo bash project5/backup.sh
sudo bash project5/restore.sh
```

### 4. Cron Job Setup (for periodic tasks like backup and system monitoring):
To schedule the scripts, open the cron job editor:

```bash
crontab -e
```

Add the following cron jobs (adjust paths to your scripts):

- Backup: `0 0 * * * /path/to/project5/backup.sh`
- System Monitoring: `0 * * * * /path/to/project3/system_monitor.sh`

## How to Verify

### User and Group Management:
- Verify users and groups:
```bash
cat /etc/passwd  # Verify user creation
cat /etc/group   # Verify group creation
```
- Check the `audit.log` file to see what actions were taken during execution.

### Apache HTTP Server:
- Access the public IP of your EC2 instance in a browser to verify the Apache server and the directories.

### System Monitoring Logs:
- Check `/var/log/system_monitor.log` after running the cron job.

### Java Application:
- Check `/home/ec2-user/app/app_output.log` to see the output of the Java application.

### Backup and Restore:
- Verify the presence of the backup file in `/backup` and the restored files in `/restore_test`.

## Contributing
Feel free to fork this repository, open issues, or submit pull requests. Any improvements or suggestions are welcome!
