#!/bin/bash

##### Started -> Logging setup #####
LOG_DIR=/var/log/my_script_logs
INSTALLATION_LOG_FILE=$LOG_DIR/installation.log

# Check if LOG_DIR is already defined in ~/.bashrc

if ! [ -d "$LOG_DIR" ]; then
  sudo mkdir $LOG_DIR
  {
    echo "export LOG_DIR=$LOG_DIR"
    echo "export INSTALLATION_LOG_FILE=$INSTALLATION_LOG_FILE"
  } >> ~/.bashrc
  . ~/.bashrc
fi


##### Completed -> Logging setup #####

echo "$(date +'%Y-%m-%d %H:%M:%S') - Starting boot script execution with apt update." >> $INSTALLATION_LOG_FILE
apt-get update
echo "$(date +'%Y-%m-%d %H:%M:%S') - After apt update, Installing git." >> $INSTALLATION_LOG_FILE
apt-get install git -y

SCRIPTS_DIR=/usr/local/git-repo/scripts
echo "$(date +'%Y-%m-%d %H:%M:%S') - After installing git, checking whether dir $SCRIPTS_DIR exists." >> $INSTALLATION_LOG_FILE

if ! [ -d "$SCRIPTS_DIR" ]; then
  echo "$(date +'%Y-%m-%d %H:%M:%S') - Creating dir $SCRIPTS_DIR" >> $INSTALLATION_LOG_FILE
  mkdir -p $SCRIPTS_DIR
fi
cd $SCRIPTS_DIR || exit
echo "$(date +'%Y-%m-%d %H:%M:%S') - Switched to dir $SCRIPTS_DIR." >> $INSTALLATION_LOG_FILE

if [ -d "$SCRIPTS_DIR/.git" ]; then
  rm -r "$SCRIPTS_DIR/.git"
    if git pull; then
        echo "$(date +'%Y-%m-%d %H:%M:%S') - Git repository inside $SCRIPTS_DIR has been updated." >> "$INSTALLATION_LOG_FILE"
    else
        echo "$(date +'%Y-%m-%d %H:%M:%S') - Error updating Git repository." >> "$INSTALLATION_LOG_FILE"
    fi
else
    git clone https://github.com/AdarshSinghal/scripts.git "$SCRIPTS_DIR"
    echo "$(date +'%Y-%m-%d %H:%M:%S') - Git repository has been cloned into $SCRIPTS_DIR" >> $INSTALLATION_LOG_FILE
fi

ENV_SCRIPT_DIR=$SCRIPTS_DIR/server/ubuntu/native/nnt

SCRIPT_JDK_MVN_INSTALL=$ENV_SCRIPT_DIR/installation-jdk-mvn.sh
chmod +x $SCRIPT_JDK_MVN_INSTALL
echo "$(date +'%Y-%m-%d %H:%M:%S') - Executing $SCRIPT_JDK_MVN_INSTALL" >> $INSTALLATION_LOG_FILE
$SCRIPT_JDK_MVN_INSTALL




#--Local variables----------------------------------------------------

#BASE_PATH=./scripts/server/alpine
#SH1_PATH=$BASE_PATH/02-docker-install.sh
#SH2_PATH=$BASE_PATH/03-docker-cmd.sh
#---------------------------------------------------------------------