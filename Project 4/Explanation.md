
# Explanation of `deploy_app.sh`

## 1. Root Check
```bash
if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root."
    exit 1
fi
```
- Ensures the script is executed as root to prevent permission issues during directory creation, file copying, and Java compilation.  

## 2. Deployment Directory Creation
```bash
mkdir -p "$DEPLOY_DIR"
```
- Creates the deployment directory (`/home/ec2-user/app`) if it does not already exist.  
- The `-p` flag avoids errors if the directory already exists.  

## 3. Copying the Java Source File
```bash
cp "$JAVA_FILE" "$DEPLOY_DIR/"
```
- Copies the `app.java` file into the deployment directory for compilation.  
- This step ensures that the script works independently from the source file location.  

## 4. Compiling the Java File
```bash
javac "$JAVA_FILE"
```
- Uses the `javac` command to compile the Java file (`app.java`) into a `.class` file.  
- The `${JAVA_FILE%.java}` syntax removes the `.java` extension to derive the class name for execution.  

## 5. Running the Application
```bash
java "$CLASS_FILE" > "$LOG_FILE" 2>&1
```
- Executes the compiled application using the `java` command.  
- Redirects both standard output and errors to the `app_output.log` file.  

---

# Steps for Execution  

## 1. Save the Java Source File  
Save the following Java code as `app.java`:  
```java
public class app {
    public static void main(String[] args) {
        System.out.println("Hello, World! Application is running.");
    }
}
```

## 2. Execute the Shell Script  
Run the script as root:  
```bash
sudo bash deploy_app.sh
```

## 3. Verify the Results  

### a. Deployment Directory  
Check the contents of the deployment directory:  
```bash
ls /home/ec2-user/app
```
Expected output:  
```plaintext
app.java
app.class
app_output.log
```

### b. Log File Output  
Check the application output in the log file:  
```bash
cat /home/ec2-user/app/app_output.log
```
Expected output:  
```plaintext
Hello, World! Application is running.
```

---

# Key Features  

1. **Portable Script:** Independent of the initial location of `app.java`.  
2. **Error Handling:** Validates each step (e.g., directory creation, file copying, compilation, execution).  
3. **Log Management:** Logs application output to `app_output.log`.  

---

# Expected Results  

## 1. Directory Structure  
The deployment directory (`/home/ec2-user/app`) will contain:  
- `app.java` (source code).  
- `app.class` (compiled bytecode).  
- `app_output.log` (application output log).  

## 2. Application Output (app_output.log):  
```plaintext
Hello, World! Application is running.
```
