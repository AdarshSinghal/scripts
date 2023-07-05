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
2. Copy Paste content of script 1 in terminal to execute them.
3. Execute `docker login -u {username}`
4. Provide token generated from DockerHub. (Can use account password, but it's unsecure way)
5. Execute `docker pull {username}/as-pvt-repo:postgres-alpine3.18`

### Script 1
```
apk add git
mkdir /usr/local/git-repo
cd /usr/local/git-repo
git clone https://github.com/AdarshSinghal/scripts.git
chmod +x ./scripts/server/alpine-init.sh
./scripts/server/alpine-init.sh
```
