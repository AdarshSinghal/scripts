## Alpine Linux Server Initialization through startup script

### Steps to be followed

1. Paste the script in `01-first-boot.sh` into Vultr Scripts. 
2. Use the script while provisioning compute instance. 
3. Once server is provisioned, connect through Putty.
4. Create two env variable - DOCKER_USER and DOCKER_PASSWORD.
```
export DOCKER_USER=actual_username
export DOCKER_PWD=actual_password
```
5. Execute `02-docker-cmd.sh`
`./02-docker-cmd.sh`