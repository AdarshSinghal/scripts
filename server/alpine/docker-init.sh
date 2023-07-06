#!/bin/bash
sleep 20s
echo $2 | docker login -u $1 --password-stdin
docker pull $1/as-pvt-repo:postgres-alpine3.18
docker run --name nnt-db -p 5432:5432 -d adarshsinghal/as-pvt-repo:postgres-alpine3.18
