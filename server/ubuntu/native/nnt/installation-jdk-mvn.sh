#!/bin/sh
. ~/.bashrc
echo "Installing openjdk-17-jdk maven" >> "$INSTALLATION_LOG_FILE"
sudo apt install openjdk-17-jdk maven -y

if ! grep -q "export JAVA_HOME" ~/.bashrc; then
echo "Setting env var for openjdk-17-jdk maven" >> "$INSTALLATION_LOG_FILE"
{
  echo "export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64"
  echo "export MAVEN_HOME=/usr/share/maven"
  echo "export PATH=$PATH:$JAVA_HOME/bin:$MAVEN_HOME/bin"
} >> ~/.bashrc
#Update env var changes
. ~/.bashrc
else
echo "Env var exists for openjdk-17-jdk maven" >> "$INSTALLATION_LOG_FILE"
fi

echo "Finished installing openjdk-17-jdk maven" >> "$INSTALLATION_LOG_FILE"