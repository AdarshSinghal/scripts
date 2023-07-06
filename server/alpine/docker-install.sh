#!/bin/bash
apk add docker
sleep 10
rc-update add docker default
sleep 10
service docker start
sleep 10
rc-update add cgroups
sleep 10
apk add docker-compose