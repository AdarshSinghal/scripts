#!/bin/bash
#Require for setting INSTALLATION_LOG_FILE
. ~/.bashrc
echo "$(date +'%Y-%m-%d %H:%M:%S') - Started executing config-jenkins-nginx.sh" >> "$INSTALLATION_LOG_FILE"
echo "$(date +'%Y-%m-%d %H:%M:%S') - Copying configuration to /etc/nginx/sites-available/" >> "$INSTALLATION_LOG_FILE"
sudo cp "$SCRIPTS_DIR"/configuration/jenkins-nginx-reverse-proxy /etc/nginx/sites-available/
echo "$(date +'%Y-%m-%d %H:%M:%S') - Creating link with /etc/nginx/sites-enabled/" >> "$INSTALLATION_LOG_FILE"
sudo ln -s /etc/nginx/sites-available/jenkins-nginx-reverse-proxy /etc/nginx/sites-enabled/
echo "$(date +'%Y-%m-%d %H:%M:%S') - Removing default" >> "$INSTALLATION_LOG_FILE"
rm /etc/nginx/sites-available/default
rm /etc/nginx/sites-enabled/default
echo "$(date +'%Y-%m-%d %H:%M:%S') - Restarting nginx" >> "$INSTALLATION_LOG_FILE"
sudo systemctl restart nginx

JENKINS_SERVICE_D=/etc/systemd/system/jenkins.service.d
echo "$(date +'%Y-%m-%d %H:%M:%S') - Need to check whether $JENKINS_SERVICE_D exists" >> "$INSTALLATION_LOG_FILE"

if ! [ -d "$JENKINS_SERVICE_D" ]; then
  echo "$(date +'%Y-%m-%d %H:%M:%S') - Creating dir $JENKINS_SERVICE_D" >> "$INSTALLATION_LOG_FILE"
  mkdir -p $JENKINS_SERVICE_D
fi

if ! [ -e "$JENKINS_SERVICE_D/override.conf" ]; then
  echo "$(date +'%Y-%m-%d %H:%M:%S') - Not found $JENKINS_SERVICE_D/override.conf. Hence, creating." >> "$INSTALLATION_LOG_FILE"
  {
    echo "[Service]"
    echo "Environment='JENKINS_PREFIX=/jenkins'"
  } >> $JENKINS_SERVICE_D/override.conf
else
  echo "$(date +'%Y-%m-%d %H:%M:%S') - Found $JENKINS_SERVICE_D/override.conf. Need to check whether Jenkins_Prefix present" >> "$INSTALLATION_LOG_FILE"
  if ! grep -q "JENKINS_PREFIX" $JENKINS_SERVICE_D/override.conf; then
    echo "$(date +'%Y-%m-%d %H:%M:%S') - Jenkins Prefix not found in override.conf. Hence, writing." >> "$INSTALLATION_LOG_FILE"
    {
    echo "[Service]"
    echo "Environment='JENKINS_PREFIX=/jenkins'"
    } >> $JENKINS_SERVICE_D/override.conf
  fi
fi
echo "$(date +'%Y-%m-%d %H:%M:%S') - Restarting jenkins" >> "$INSTALLATION_LOG_FILE"
sudo systemctl restart jenkins
echo "$(date +'%Y-%m-%d %H:%M:%S') - Finished executing config-jenkins-nginx.sh" >> "$INSTALLATION_LOG_FILE"
