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

log "*** Started execution - installation-maven.sh ***"
apt install maven -y
log "maven installation finished. Now setting env variable."

#Set env variable
maven_home="MAVEN_HOME=/usr/share/maven"
if grep -q "^$maven_home" /etc/environment; then
  log "MAVEN_HOME is already present in /etc/environment."
else
    echo -e "$maven_home" >> /etc/environment
    log "Added MAVEN_HOME to /etc/environment."
fi
log "*** Finished execution - installation-maven.sh ***"