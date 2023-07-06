#!/bin/bash
# Make sure to read ReadMe before executing this file.

#--Local variables----------------------------------------------------
GIT_REPO_URL=https://github.com/AdarshSinghal/scripts.git
BASE_PATH=scripts/server/alpine
WORK_DIR=/usr/local/git-repo
#---------------------------------------------------------------------

apk add git
mkdir -p $WORK_DIR
cd $WORK_DIR || exit
git clone $GIT_REPO_URL
chmod +x ./$BASE_PATH/01-docker-install.sh
./$BASE_PATH/docker-install.sh
chmod +x ./$BASE_PATH/02-docker-cmd.sh
./$BASE_PATH/docker-init.sh
