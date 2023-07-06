#!/bin/bash
apk add docker
sleep 5
rc-update add docker default
sleep 5
service docker start > /tmp/docker_start.log 2>&1
rc-update add cgroups
sleep 5
apk add docker-compose