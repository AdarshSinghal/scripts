#!/bin/bash
sudo apt update
apt-get install git -y


#-------clone into workdir-------
WORK_DIR=/usr/local/git-repo
mkdir -p $WORK_DIR
cd $WORK_DIR
git clone https://github.com/AdarshSinghal/scripts.git
#--------------------------------


#-----set scripts executable and then execute it-----

#Local variables
SCRIPT_PATH=$WORK_DIR/scripts/server/ubuntu/vultr
SCRIPT_1=$SCRIPT_PATH/01-install-docker.sh
SCRIPT_2=$SCRIPT_PATH/02-docker-cmd.sh

chmod +x $SCRIPT_1
$SCRIPT_1
export DOCKER_USERNAME=
export DOCKER_PASSWORD=
chmod +x $SCRIPT_2
$SCRIPT_2
#-----------------------------------------------------
