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

log "*** Started execution - update-reboot.sh ***"
export DEBIAN_FRONTEND=noninteractive

log "Executing update."
apt-get update
log "After update, executing upgrade."
start_time=$(date +%s)
apt-get upgrade -y
end_time=$(date +%s)
time_taken=$((end_time - start_time))
unset DEBIAN_FRONTEND
# Check if time taken is greater than 10 seconds
if [ $time_taken -gt 30 ]; then
    log "Completed upgrade. Rebooting system."
    sudo reboot
fi
log "*** Finished execution - update-reboot.sh ***"