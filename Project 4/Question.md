# Project 4: Deployment of a Custom Application  

## Objective  
Deploy and execute a simple Java application using shell scripting.  

## Tasks  
1. Write a shell script (`deploy_app.sh`) to:  
   - Create a deployment directory (e.g., `/home/ec2-user/app`).  
   - Copy a provided `app.java` file into the deployment directory.  
   - Compile the `app.java` file into a `.class` file using `javac`.  
   - Set execute permissions for the `.class` file.  
   - Execute the application and log the output to a file (`app_output.log`).  
2. Verify that the application runs successfully by checking the output in the log file.  

## Deliverables  
- The shell script (`deploy_app.sh`).  
- The `app.java` file used in the deployment.  
- The `app_output.log` file showing the application output.  
