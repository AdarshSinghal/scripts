#!/bin/bash
#Require for setting INSTALLATION_LOG_FILE
. ~/.bashrc

echo "$(date +'%Y-%m-%d %H:%M:%S') - Started executing installation-jenkins-nginx.sh" >> "$INSTALLATION_LOG_FILE"
echo "$(date +'%Y-%m-%d %H:%M:%S') - Installing curl" >> "$INSTALLATION_LOG_FILE"
sudo apt-get curl -y
echo "$(date +'%Y-%m-%d %H:%M:%S') - Using curl for retrieving jenkins pkg" >> "$INSTALLATION_LOG_FILE"
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

echo "$(date +'%Y-%m-%d %H:%M:%S') - Executing apt update" >> "$INSTALLATION_LOG_FILE"
sudo apt update
echo "$(date +'%Y-%m-%d %H:%M:%S') - Installing jenkins" >> "$INSTALLATION_LOG_FILE"
sudo apt install jenkins -y
echo "$(date +'%Y-%m-%d %H:%M:%S') - Installing nginx" >> "$INSTALLATION_LOG_FILE"
sudo apt install nginx -y
echo "$(date +'%Y-%m-%d %H:%M:%S') - Finished installing jenkins and nginx" >> "$INSTALLATION_LOG_FILE"

echo "******$(date +'%Y-%m-%d %H:%M:%S') - Inside installation-jenkins-nginx ENV_SCRIPT_DIR - $ENV_SCRIPT_DIR." >> "$INSTALLATION_LOG_FILE"
SCRIPT_CONFIG_JENKINS_NGINX=$SCRIPTS_DIR/server/ubuntu/aws/devtools/config-jenkins-nginx.sh
chmod +x "$SCRIPT_CONFIG_JENKINS_NGINX"
echo "$(date +'%Y-%m-%d %H:%M:%S') - Executing $SCRIPT_CONFIG_JENKINS_NGINX" >> "$INSTALLATION_LOG_FILE"
source "$SCRIPT_CONFIG_JENKINS_NGINX"