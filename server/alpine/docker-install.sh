#!/bin/bash
sleep 5
apk add docker
sleep 5
sudo rc-update add docker default
sleep 5
sudo service docker start
sudo rc-update add cgroups
sleep 5
sudo apk add docker-compose