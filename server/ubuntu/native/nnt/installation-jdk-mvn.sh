#!/bin/bash
#Require for setting INSTALLATION_LOG_FILE
. ~/.bashrc
echo "$(date +'%Y-%m-%d %H:%M:%S') - Started executing installation-jdk-mvn.sh" >> "$INSTALLATION_LOG_FILE"
echo "$(date +'%Y-%m-%d %H:%M:%S') - Installing jdk and mvn" >> "$INSTALLATION_LOG_FILE"
sudo apt install openjdk-17-jdk maven -y

if ! grep -q "export JAVA_HOME" ~/.bashrc; then
echo "$(date +'%Y-%m-%d %H:%M:%S') - Setting env var for jdk17 and maven" >> "$INSTALLATION_LOG_FILE"
{
  echo "export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64"
  echo "export MAVEN_HOME=/usr/share/maven"
  echo "export PATH=$PATH:$JAVA_HOME/bin:$MAVEN_HOME/bin"
} >> ~/.bashrc
#Update env var changes
. ~/.bashrc
else
echo "$(date +'%Y-%m-%d %H:%M:%S') - Env var exists for jdk17 and maven" >> "$INSTALLATION_LOG_FILE"
fi

echo "$(date +'%Y-%m-%d %H:%M:%S') - Finished installing jdk17 and maven" >> "$INSTALLATION_LOG_FILE"