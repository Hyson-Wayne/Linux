# Project 2: Apache HTTP Server Deployment and Customization

## Explanation

### 1. Root Privilege Check
```bash
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root."
    exit 1
fi
```
- Ensures the script is executed with administrative privileges.
- Root access is necessary to install and manage services.

---

### 2. Apache Installation
```bash
yum install -y httpd
```
- Installs the Apache HTTP server (`httpd`) package.
- `-y` automatically confirms the installation prompts.
- Checks the success of the installation using `$?`.

---

### 3. Start and Enable Apache
```bash
systemctl start httpd
systemctl enable httpd
```
- **`systemctl start httpd`**: Starts the Apache service.
- **`systemctl enable httpd`**: Ensures Apache starts automatically when the system boots.

---

### 4. Create Project Directories and Add Content
```bash
for project in project1 project2; do
    mkdir -p "$PROJECT_DIR/$project"
    echo "<h1>Welcome to $project</h1>" > "$PROJECT_DIR/$project/index.html"
done
```
- Iterates through project names (`project1`, `project2`).
- Creates directories under `/var/www/html`.
- Adds an `index.html` file with custom content for each directory.

---

### 5. Add Content to Root Directory
```bash
echo "<h1>Welcome to the Apache Server</h1>" > "$PROJECT_DIR/index.html"
```
- Sets up the default homepage for the root directory (`/var/www/html`).

---

### 6. Restart Apache
```bash
systemctl restart httpd
```
- Restarts the Apache service to apply changes, including new directories and files.

---

### Validation

1. Save the script as `deploy_apache.sh`.
2. Run it with root privileges:
   ```bash
   sudo bash deploy_apache.sh
   ```
3. Access the Apache server using the public IP address:
   - **Root directory**: `http://<PUBLIC_IP>`
   - **Project1**: `http://<PUBLIC_IP>/project1`
   - **Project2**: `http://<PUBLIC_IP>/project2`

---

## Expected Results
1. **Root URL**: Displays the message:
   ```html
   <h1>Welcome to the Apache Server</h1>
   ```
2. **Project URLs**: Display messages:
   - `/project1`: `<h1>Welcome to project1</h1>`
   - `/project2`: `<h1>Welcome to project2</h1>`

---

## Error Handling
- The script checks for errors after each major command and exits with an error message if any issue occurs. This ensures reliable execution.

```bash
if [[ $? -ne 0 ]]; then
    echo "Error message"
    exit 1
fi
```
