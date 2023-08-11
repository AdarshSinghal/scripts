#!/bin/bash

##### Started -> Logging setup #####
LOG_DIR=/var/log/my_script_logs
INSTALLATION_LOG_FILE=$LOG_DIR/installation.log

# Check if LOG_DIR is already defined in ~/.bashrc
if ! grep -q "export LOG_DIR=$LOG_DIR" ~/.bashrc; then
  {
    echo "export LOG_DIR=$LOG_DIR"
    echo "export INSTALLATION_LOG_FILE=$INSTALLATION_LOG_FILE"
  } >> ~/.bashrc
  . ~/.bashrc
fi

sudo mkdir $LOG_DIR
##### Completed -> Logging setup #####

echo "Starting boot script execution with apt update." >> $INSTALLATION_LOG_FILE
apt-get update
echo "After apt update, Installing git." >> $INSTALLATION_LOG_FILE
apt-get install git -y

SCRIPTS_DIR=/usr/local/git-repo/scripts
echo "After installing git, checking whether dir $SCRIPTS_DIR exists." >> $INSTALLATION_LOG_FILE

if ! [ -d "$SCRIPTS_DIR" ]; then
  echo "Creating dir $SCRIPTS_DIR" >> $INSTALLATION_LOG_FILE
  mkdir -p $SCRIPTS_DIR
fi
cd $SCRIPTS_DIR || exit
echo "Switched to dir $SCRIPTS_DIR." >> $INSTALLATION_LOG_FILE

if [ -d "$SCRIPTS_DIR/.git" ]; then
    git pull
    echo "Git repository inside $SCRIPTS_DIR has been updated." >> $INSTALLATION_LOG_FILE
else
    git clone https://github.com/AdarshSinghal/scripts.git "$SCRIPTS_DIR"
    echo "Git repository has been cloned into $SCRIPTS_DIR" >> $INSTALLATION_LOG_FILE
fi

ENV_SCRIPT_DIR=$SCRIPTS_DIR/server/ubuntu/native/nnt

SCRIPT_JDK_MVN_INSTALL=$ENV_SCRIPT_DIR/installation-jdk-mvn.sh
chmod +x $SCRIPT_JDK_MVN_INSTALL
echo "Executing $SCRIPT_JDK_MVN_INSTALL" >> $INSTALLATION_LOG_FILE
$SCRIPT_JDK_MVN_INSTALL




#--Local variables----------------------------------------------------

#BASE_PATH=./scripts/server/alpine
#SH1_PATH=$BASE_PATH/02-docker-install.sh
#SH2_PATH=$BASE_PATH/03-docker-cmd.sh
#---------------------------------------------------------------------