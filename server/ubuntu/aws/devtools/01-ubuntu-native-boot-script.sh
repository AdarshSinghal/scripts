#!/bin/bash

######################### Logging setup #########################
LOG_DIR=/var/log/my_script_logs
INSTALLATION_LOG_FILE=$LOG_DIR/installation.log

# Check if LOG_DIR is already defined in ~/.bashrc
if ! [ -d "$LOG_DIR" ]; then
  mkdir $LOG_DIR
  {
    echo "export LOG_DIR=$LOG_DIR"
    echo "export INSTALLATION_LOG_FILE=$INSTALLATION_LOG_FILE"
  } >> ~/.bashrc
  . ~/.bashrc
fi
######################### Logging setup #########################

echo "$(date +'%Y-%m-%d %H:%M:%S') - Starting boot script execution with apt update." >> $INSTALLATION_LOG_FILE
apt-get update
echo "$(date +'%Y-%m-%d %H:%M:%S') - After apt update, Installing git." >> $INSTALLATION_LOG_FILE
apt-get install git -y

#Check if dir SCRIPTS_DIR present
SCRIPTS_DIR=/usr/local/git-repo/scripts
echo "$(date +'%Y-%m-%d %H:%M:%S') - After installing git, checking whether dir $SCRIPTS_DIR exists." >> $INSTALLATION_LOG_FILE
if ! [ -d "$SCRIPTS_DIR" ]; then
  echo "$(date +'%Y-%m-%d %H:%M:%S') - Creating dir SCRIPTS_DIR $SCRIPTS_DIR" >> $INSTALLATION_LOG_FILE
  mkdir -p $SCRIPTS_DIR
else
  echo "$(date +'%Y-%m-%d %H:%M:%S') - Found dir SCRIPTS_DIR $SCRIPTS_DIR" >> $INSTALLATION_LOG_FILE
fi

#Check if var SCRIPTS_DIR present
if ! grep -q "export SCRIPTS_DIR" ~/.bashrc; then
  echo "$(date +'%Y-%m-%d %H:%M:%S') - Setting var SCRIPTS_DIR=$SCRIPTS_DIR" >> $INSTALLATION_LOG_FILE
  echo "export SCRIPTS_DIR=$SCRIPTS_DIR" >> ~/.bashrc
else
  echo "$(date +'%Y-%m-%d %H:%M:%S') - Found var SCRIPTS_DIR in ~/.bashrc" >> $INSTALLATION_LOG_FILE
fi

#git clone or git pull, depends on repository existence in SCRIPTS_DIR
cd $SCRIPTS_DIR || exit
echo "$(date +'%Y-%m-%d %H:%M:%S') - Switched to dir $SCRIPTS_DIR." >> $INSTALLATION_LOG_FILE
if [ -d "$SCRIPTS_DIR/.git" ]; then
  git restore .
  if git pull; then
    echo "$(date +'%Y-%m-%d %H:%M:%S') - Git repository inside $SCRIPTS_DIR has been updated." >> "$INSTALLATION_LOG_FILE"
  else
    echo "$(date +'%Y-%m-%d %H:%M:%S') - Error updating Git repository." >> "$INSTALLATION_LOG_FILE"
  fi
else
    git clone https://github.com/AdarshSinghal/scripts.git "$SCRIPTS_DIR"
    echo "$(date +'%Y-%m-%d %H:%M:%S') - Git repository has been cloned into $SCRIPTS_DIR" >> $INSTALLATION_LOG_FILE
fi

#Execute the 02-installation.sh script
SCRIPT_INSTALLATION=$SCRIPTS_DIR/server/ubuntu/aws/devtools/02-installation.sh
chmod +x $SCRIPT_INSTALLATION
echo "$(date +'%Y-%m-%d %H:%M:%S') - Executing $SCRIPT_INSTALLATION" >> $INSTALLATION_LOG_FILE
source $SCRIPT_INSTALLATION