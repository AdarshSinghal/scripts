#!/bin/bash

#Set Env variable first - DOCKER_USERNAME, DOCKER_PASSWORD.

REPO=$DOCKER_USERNAME/as-pvt-repo
DB_IMG=$REPO:postgres-alpine3.18

echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin
docker pull $DB_IMG
docker run --name nnt-db -p 5432:5432 -d $DB_IMG
