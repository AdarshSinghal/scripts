#!/bin/bash
apk add docker
rc-update add docker default

mount -t tmpfs cgroup_root /sys/fs/cgroup
mkdir /sys/fs/cgroup/devices
mount -o devices cgroup -t cgroup /sys/fs/cgroup/devices
dockerd &
#service docker start

rc-update add cgroups
apk add docker-compose