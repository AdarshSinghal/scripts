#!/bin/bash
apk add docker
sleep 5
rc-update add docker default
sleep 5
sudo service docker start
rc-update add cgroups
sleep 5
apk add docker-compose