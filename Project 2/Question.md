# Project 2: Apache HTTP Server Deployment and Customization

## Objective
Deploy an Apache web server on an Amazon Linux EC2 instance and customize its content using scripting.

## Tasks
1. Launch an Amazon Linux EC2 instance and connect via SSH.
2. Write a shell script to:
   - Install the Apache HTTP server (httpd).
   - Start and enable the Apache service to run on boot.
   - Create directories under `/var/www/html/` (e.g., `project1`, `project2`).
   - Add unique HTML content to each directory and the default root directory.
3. Verify the setup:
   - Access the directories using the instance’s public IP address (e.g., `http://<Public_IP>/project1`).
   - Capture screenshots of the pages in the browser.

## Deliverables
- The shell script (`deploy_apache.sh`).
- Browser screenshots showing content for the root and custom directories.
