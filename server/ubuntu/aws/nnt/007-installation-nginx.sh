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

echo "$(date +'%Y-%m-%d %H:%M:%S') - nginx installation started" >> "$INSTALLATION_LOG_FILE"
apt-get install nginx -y
echo "$(date +'%Y-%m-%d %H:%M:%S') - nginx installation finished" >> "$INSTALLATION_LOG_FILE"