#!/bin/bash

apt-get update
apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \

sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y


#--Local variables----------------------------------------------------
GIT_REPO_URL=https://github.com/AdarshSinghal/scripts.git
BASE_PATH=scripts/server/ubuntu/vultr
WORK_DIR=/usr/local/git-repo
#---------------------------------------------------------------------

apt-get install git -y
mkdir -p $WORK_DIR
cd $WORK_DIR || exit
git clone $GIT_REPO_URL
chmod +x ./$BASE_PATH/02-docker-cmd.sh