#!/bin/bash
#Require for setting INSTALLATION_LOG_FILE, SCRIPTS_DIR
. ~/.bashrc

ENV_SCRIPT_DIR=$SCRIPTS_DIR/server/ubuntu/aws/devtools
echo "$(date +'%Y-%m-%d %H:%M:%S') - Started executing installation.sh, which is present in $ENV_SCRIPT_DIR." >> "$INSTALLATION_LOG_FILE"

SCRIPT_JDK_MVN_INSTALL=$ENV_SCRIPT_DIR/installation-jdk-mvn.sh
chmod +x "$SCRIPT_JDK_MVN_INSTALL"
echo "$(date +'%Y-%m-%d %H:%M:%S') - Executing $SCRIPT_JDK_MVN_INSTALL" >> "$INSTALLATION_LOG_FILE"
source "$SCRIPT_JDK_MVN_INSTALL"

SCRIPT_JENKINS_NGINX_INSTALL=$ENV_SCRIPT_DIR/installation-jenkins-nginx.sh
chmod +x "$SCRIPT_JENKINS_NGINX_INSTALL"
echo "$(date +'%Y-%m-%d %H:%M:%S') - Executing $SCRIPT_JENKINS_NGINX_INSTALL" >> "$INSTALLATION_LOG_FILE"
source "$SCRIPT_JENKINS_NGINX_INSTALL"

SCRIPT_POSTGRES_INSTALL=$ENV_SCRIPT_DIR/installation-postgresql.sh
chmod +x "$SCRIPT_POSTGRES_INSTALL"
echo "$(date +'%Y-%m-%d %H:%M:%S') - Executing $SCRIPT_POSTGRES_INSTALL" >> "$INSTALLATION_LOG_FILE"
source "$SCRIPT_POSTGRES_INSTALL"