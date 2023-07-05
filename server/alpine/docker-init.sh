echo $DOCKER_PWD | docker login -u $DOCKER_USER --password-stdin
docker pull $DOCKER_USER/as-pvt-repo:postgres-alpine3.18