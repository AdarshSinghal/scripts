## Alpine Linux Server Initialization for Docker Environment
### End goal
- Automate the server initialization through script (alpine.sh)
- Script and instruction to be maintained through Github

### Why manual steps are required?
- Need to install git and clone the repository so that server can have sh file
- To make the sh file executable and execute the sh file

### Why Git? Transferring sh file through FTP could be easy option.
- Steps for manual and automation setup will evolve.
- Hence, it's better to manage it with VCS.


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

