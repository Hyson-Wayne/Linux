#!/bin/bash

# Ensure the script is run as root
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root."
    exit 1
fi

# Variables
DEPLOY_DIR="/home/ec2-user/app"
JAVA_FILE="app.java"
LOG_FILE="$DEPLOY_DIR/app_output.log"

# Step 1: Create the deployment directory
echo "Creating deployment directory at $DEPLOY_DIR..."
mkdir -p "$DEPLOY_DIR"
if [[ $? -eq 0 ]]; then
    echo "Deployment directory created successfully."
else
    echo "Failed to create deployment directory."
    exit 1
fi

# Step 2: Copy the Java source file
echo "Copying $JAVA_FILE to $DEPLOY_DIR..."
cp "$JAVA_FILE" "$DEPLOY_DIR/"
if [[ $? -eq 0 ]]; then
    echo "$JAVA_FILE copied successfully."
else
    echo "Failed to copy $JAVA_FILE."
    exit 1
fi

# Navigate to the deployment directory
cd "$DEPLOY_DIR"

# Step 3: Compile the Java source file
echo "Compiling $JAVA_FILE..."
javac "$JAVA_FILE"
if [[ $? -eq 0 ]]; then
    echo "$JAVA_FILE compiled successfully."
else
    echo "Compilation failed for $JAVA_FILE."
    exit 1
fi

# Step 4: Run the compiled application
CLASS_FILE="${JAVA_FILE%.java}" # Remove .java extension for the class name
echo "Running the application $CLASS_FILE..."
java "$CLASS_FILE" > "$LOG_FILE" 2>&1
if [[ $? -eq 0 ]]; then
    echo "Application executed successfully. Output logged to $LOG_FILE."
else
    echo "Application execution failed. Check $LOG_FILE for details."
    exit 1
fi
