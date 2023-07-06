#!/bin/bash

apk add docker
rc-update add docker default

mount -t tmpfs cgroup_root /sys/fs/cgroup
mkdir /sys/fs/cgroup/devices
mount -o devices cgroup -t cgroup /sys/fs/cgroup/devices
dockerd &

rc-update add cgroups
apk add docker-compose

#--Local variables----------------------------------------------------
GIT_REPO_URL=https://github.com/AdarshSinghal/scripts.git
BASE_PATH=scripts/server/alpine/vultr
WORK_DIR=/usr/local/git-repo
#---------------------------------------------------------------------

apk add git
mkdir -p $WORK_DIR
cd $WORK_DIR || exit
git clone $GIT_REPO_URL
chmod +x ./$BASE_PATH/02-docker-cmd.sh