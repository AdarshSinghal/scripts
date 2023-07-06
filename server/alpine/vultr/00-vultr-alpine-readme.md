## Alpine Linux Server Initialization through startup script

### Steps to be followed

1. Paste the script in `01-first-boot.sh` into Vultr Scripts. 
2. Use the script while provisioning compute instance. Once server is provisioned, connect through Putty.
3. Create two env variable - DOCKER_USERNAME and DOCKER_PASSWORD.
```
export DOCKER_USERNAME=actual_username
export DOCKER_PASSWORD=actual_password
```
4. Execute`/usr/local/git-repo/scripts/server/alpine/vultr/02-docker-cmd.sh`
