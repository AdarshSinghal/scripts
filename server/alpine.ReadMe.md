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

### Script
```
apk add git
mkdir /usr/local/git-repo
cd /usr/local/git-repo
git clone https://github.com/AdarshSinghal/scripts.git
chmod +x ./scripts/server/alpine.sh
./scripts/server/alpine.sh
```
### Steps to be followed
After connecting the alpine server from putty, start executing the commands in above script.
