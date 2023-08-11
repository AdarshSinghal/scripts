#!/bin/sh
echo "Installing openjdk-17-jdk maven" >> "$INSTALLATION_LOG_FILE"
sudo apt install openjdk-17-jdk maven -y

{
  echo "export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64"
  echo "export PATH=$PATH:$JAVA_HOME/bin"
  echo "export MAVEN_HOME=/usr/share/maven"
  echo "export PATH=$PATH:$MAVEN_HOME/bin"
} >> ~/.bashrc

. ~/.bashrc

echo "Finished installing openjdk-17-jdk maven" >> "$INSTALLATION_LOG_FILE"