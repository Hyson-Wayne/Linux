#!/bin/bash

# Ensure the script is run as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root."
    exit 1
fi

# Install Apache HTTP Server
echo "Installing Apache HTTP Server..."
yum install -y httpd
if [[ $? -eq 0 ]]; then
    echo "Apache installed successfully."
else
    echo "Failed to install Apache."
    exit 1
fi

# Start Apache service
echo "Starting Apache service..."
systemctl start httpd
if [[ $? -eq 0 ]]; then
    echo "Apache service started successfully."
else
    echo "Failed to start Apache service."
    exit 1
fi

# Enable Apache to start on boot
echo "Enabling Apache to start on boot..."
systemctl enable httpd
if [[ $? -eq 0 ]]; then
    echo "Apache service enabled on boot."
else
    echo "Failed to enable Apache service on boot."
    exit 1
fi

# Create directories and add content
PROJECT_DIR="/var/www/html"
for project in project1 project2; do
    echo "Setting up $project..."
    mkdir -p "$PROJECT_DIR/$project"
    echo "<h1>Welcome to $project</h1>" > "$PROJECT_DIR/$project/index.html"
    if [[ $? -eq 0 ]]; then
        echo "Content added to $project."
    else
        echo "Failed to add content to $project."
        exit 1
    fi
done

# Add content to the root directory
echo "Adding content to the root directory..."
echo "<h1>Welcome to the Apache Server</h1>" > "$PROJECT_DIR/index.html"
if [[ $? -eq 0 ]]; then
    echo "Root content added successfully."
else
    echo "Failed to add content to the root directory."
    exit 1
fi

# Restart Apache to apply changes
echo "Restarting Apache service..."
systemctl restart httpd
if [[ $? -eq 0 ]]; then
    echo "Apache setup completed successfully. Visit the server's IP in a browser."
else
    echo "Failed to restart Apache service."
    exit 1
fi
