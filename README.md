# Scripts

This repository contains scripts for initializing the provisioned cloud resources with minimal recurring effort in infrastructure setup for application deployment.
- I preferred Alpine Linux because server should have minimal packages installed and it's image should be less in size.
- I preferred running Docker on top of Alpine because I prefer to test and run app in Docker otherwise using different OS and application versions for Development and Production env has it's own risk.

## Alpine Linux Server Initialization for Docker Environment
### End goal
- Automate the server initialization through script (alpine.sh)
- Script and instruction to be maintained through Github

### What is automated and what is manual steps?
#### Automated
- Installation of required packages (GIT, Docker)
- Pulling scripts from GIT
- Setting permission and execution of script in correct order.
- Logging in into DockerHub and pulling the required image.
#### Manual
- Set Env variable which will be used by scripts.
- Execute the first script manually




### Steps to be followed

1. Connect the alpine server from putty
2. Provide correct value to DOCKER_USER and DOCKER_PWD variable and execute.
```
export DOCKER_USER=actual_username
export DOCKER_PWD=actual_password
```

3. Execute `01_alpine-init.sh`
    1. Open vim using `vim 01_alpine-init.sh` and press insert key for entering into Insert mode.
    2. Copy Paste content of script `01_alpine-init.sh` into vim (use Shift + Insert) and press escape to get out of Insert mode.
    3. Save the file using :wq > Enter
    4. Make file executable `chmod +x ./01_alpine-init.sh`
    5. Execute script `./01_alpine-init.sh`

### FTP Client usage
- It can help to skip vim part mentioned in step 3 (3.1 to 3.3)
- However I mentioned vim shortcuts as server setup is rare event.

### Can it be simplified further?
Yes, In GCP, there is provision to provide startup script. That means above mentioned manual steps is not required as script is provided in instance configuration itself. However, some cloud providers don't have this flexibility and there are other factors such as pricing is involved while choosing cloud providers.
