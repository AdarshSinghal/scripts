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

log "$(date +'%Y-%m-%d %H:%M:%S') - nginx installation started"
apt install nginx -y
log "$(date +'%Y-%m-%d %H:%M:%S') - nginx installation finished"