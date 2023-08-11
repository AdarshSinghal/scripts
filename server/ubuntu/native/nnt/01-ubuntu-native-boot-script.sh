#!/bin/bash
# Make sure to read ReadMe before executing this file.

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

echo "Starting script execution with apt update..." >> $INSTALLATION_LOG_FILE
apt-get update
echo "Installing git..." >> $INSTALLATION_LOG_FILE
apt-get install git -y
echo "Installed git" >> $INSTALLATION_LOG_FILE

WORK_DIR=/usr/local/git-repo
if ! [ -d "$WORK_DIR" ]; then
  mkdir -p $WORK_DIR
fi
cd $WORK_DIR || exit

GIT_REPO=$WORK_DIR/scripts
if [ -d "$GIT_REPO" ]; then
    echo "Git repository already exists in $WORK_DIR." >> $INSTALLATION_LOG_FILE
    cd "$GIT_REPO" || return
    git pull
    echo "Git repository has been updated." >> $INSTALLATION_LOG_FILE
else
    echo "Git repository does not exist in $WORK_DIR. Cloning..." >> $INSTALLATION_LOG_FILE
    git clone https://github.com/AdarshSinghal/scripts.git "$WORK_DIR"
    echo "Git repository has been cloned." >> $INSTALLATION_LOG_FILE
fi

SCRIPT_DIR=$GIT_REPO/server/ubuntu/native/nnt
SCRIPT_JDK_MVN_INSTALL=$SCRIPT_DIR/installation-jdk-mvn.sh






#--Local variables----------------------------------------------------

#BASE_PATH=./scripts/server/alpine
#SH1_PATH=$BASE_PATH/02-docker-install.sh
#SH2_PATH=$BASE_PATH/03-docker-cmd.sh
#---------------------------------------------------------------------