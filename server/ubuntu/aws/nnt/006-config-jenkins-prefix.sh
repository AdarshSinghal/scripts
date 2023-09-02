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

echo "$(date +'%Y-%m-%d %H:%M:%S') - *** Started executing 007-config-jenkins-prefix.sh ***" >> "$INSTALLATION_LOG_FILE"
jenkins_service_dir=/etc/systemd/system/jenkins.service.d


if ! [ -d "$jenkins_service_dir" ]; then
  echo "$(date +'%Y-%m-%d %H:%M:%S') - Creating jenkins_service_dir($jenkins_service_dir)" >> "$INSTALLATION_LOG_FILE"
  mkdir -p $jenkins_service_dir
else
  echo "$(date +'%Y-%m-%d %H:%M:%S') - Found jenkins_service_dir($jenkins_service_dir)" >> "$INSTALLATION_LOG_FILE"
fi

writePrefix() {
  echo "$(date +'%Y-%m-%d %H:%M:%S') - $1" >> "$INSTALLATION_LOG_FILE"
  {
      echo "[Service]"
      echo "Environment='JENKINS_PREFIX=/jenkins'"
  } >> $jenkins_service_dir/override.conf
  echo "$(date +'%Y-%m-%d %H:%M:%S') - Restarting jenkins" >> "$INSTALLATION_LOG_FILE"
  systemctl daemon-reload
  systemctl restart jenkins
}

if ! [ -e "$jenkins_service_dir/override.conf" ]; then
  writePrefix "Not found jenkins_service_dir/override.conf. Hence, creating."
else
  echo "$(date +'%Y-%m-%d %H:%M:%S') - Found jenkins_service_dir/override.conf. Need to check whether Jenkins_Prefix present" >> "$INSTALLATION_LOG_FILE"
  if ! grep -q "JENKINS_PREFIX" $jenkins_service_dir/override.conf; then
    writePrefix "Not found Jenkins Prefix in override.conf. Hence, writing."
  fi
fi
echo "$(date +'%Y-%m-%d %H:%M:%S') - *** Finished executing 007-config-jenkins-prefix.sh ***" >> "$INSTALLATION_LOG_FILE"
