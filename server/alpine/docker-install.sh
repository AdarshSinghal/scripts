#!/bin/bash
apk add docker
rc-update add docker default
service docker start
rc-update add cgroups
apk add docker-compose