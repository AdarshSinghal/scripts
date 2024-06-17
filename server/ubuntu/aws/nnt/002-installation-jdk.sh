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

log "*** Started execution - installation-jdk.sh ***"
apt install -y git curl gpg wget ca-certificates git sudo maven zip unzip libcap2-bin apt-file
apt-file update
apt install openjdk-21-jdk -y
log "jdk installation finished. Now setting env variable."

#Set env variable
java_home="JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64"
if grep -q "^$java_home" /etc/environment; then
  log "JAVA_HOME is already present in /etc/environment."
else
  echo -e "$java_home" >> /etc/environment
  log "Added JAVA_HOME to /etc/environment."
fi
log "*** Finished execution - installation-jdk.sh ***"