#!/bin/bash
######################### Logging setup #########################
LOG_DIR=/var/log/my_script_logs
if ! [ -d "$LOG_DIR" ]; then
  mkdir $LOG_DIR
fi

log() {
  echo "$(date +'%Y-%m-%d %H:%M:%S') - $1" >> $LOG_DIR/installation.log
}
######################### Logging setup #########################

log "*** Started execution - installation-hashicorp-vault.sh ***"
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install vault
log "*** Finished execution - installation-hashicorp-vault.sh ***"