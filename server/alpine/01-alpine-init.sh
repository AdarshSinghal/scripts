#!/bin/bash
# Make sure to read ReadMe before executing this file.

#--Local variables----------------------------------------------------
GIT_REPO_URL=https://github.com/AdarshSinghal/scripts.git
WORK_DIR=/usr/local/git-repo

BASE_PATH=./scripts/server/alpine
SH1_PATH=$BASE_PATH/02-docker-install.sh
SH2_PATH=$BASE_PATH/03-docker-cmd.sh
#---------------------------------------------------------------------

apk add git
mkdir -p $WORK_DIR
cd $WORK_DIR || exit
git clone $GIT_REPO_URL
chmod +x $SH1_PATH
$SH1_PATH
chmod +x $SH2_PATH
$SH2_PATH