#!/bin/sh
. ~/.bashrc
echo "$(date +'%Y-%m-%d %H:%M:%S') - Installing openjdk-17-jdk maven" >> "$INSTALLATION_LOG_FILE"
sudo apt install openjdk-17-jdk maven -y

if ! grep -q "export JAVA_HOME" ~/.bashrc; then
echo "$(date +'%Y-%m-%d %H:%M:%S') - Setting env var for openjdk-17-jdk maven" >> "$INSTALLATION_LOG_FILE"
{
  echo "export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64"
  echo "export MAVEN_HOME=/usr/share/maven"
  echo "export PATH=$PATH:$JAVA_HOME/bin:$MAVEN_HOME/bin"
} >> ~/.bashrc
#Update env var changes
# shellcheck disable=SC1090
. ~/.bashrc
else
echo "$(date +'%Y-%m-%d %H:%M:%S') - Env var exists for openjdk-17-jdk maven" >> "$INSTALLATION_LOG_FILE"
fi

echo "$(date +'%Y-%m-%d %H:%M:%S') - Finished installing openjdk-17-jdk maven" >> "$INSTALLATION_LOG_FILE"