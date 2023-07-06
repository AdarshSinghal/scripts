#!/bin/bash
sleep 20s
echo $DOCKER_PWD | docker login -u $DOCKER_USER --password-stdin
docker pull $DOCKER_USER/as-pvt-repo:postgres-alpine3.18
docker run --name nnt-db -p 5432:5432 -d adarshsinghal/as-pvt-repo:postgres-alpine3.18
