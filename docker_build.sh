#!/bin/bash

# First run:
# aws configure
# Then, need to let docker cli login first like this:
# aws ecr get-login-password --region ap-southeast-1 | docker login --username AWS 
# --password-stdin 079779381212.dkr.ecr.ap-southeast-1.amazonaws.com
# on K8S
# https://www.youtube.com/watch?v=asIS4KIs40M at 14:27
# Alternative material,
# https://medium.com/clarusway/how-to-use-images-from-a-private-container-registry-for-kubernetes-aws-ecr-hosted-private-13a759e2c4ea
# username is "AWS" password is the token obtained from:
# aws ecr get-login-password --region ap-southeast-1

if [ ! $# == 1 ]; then
    echo "One argument: version"
    exit
else
    version=$1
    repo=079779381212.dkr.ecr.ap-southeast-1.amazonaws.com
    image=timescaledb

    echo docker build -t version .
    docker buildx build -t --platform linux/amd64 $version . || exit 1
    env GOOS=linux GOARCH=amd64 go build -o server -tags dock -ldflags "-X main.version=$version -X main.build=`date -u +%Y%m%d.%H%M%S` -X dockrest/gconst.UnlimitedVersion=unlimited -X dockrest/gconst.App=dock" .  || exit 1

    # https://medium.com/geekculture/from-apple-silicon-to-heroku-docker-registry-without-swearing-36a2f59b30a3
    echo docker buildx build --platform linux/amd64 -f Dockerfile_local . --build-arg VERSION=$version --tag=$repo/$image:$version || exit 1
    docker buildx build --platform linux/amd64 -f Dockerfile_local . --build-arg VERSION=$version --tag=$repo/$image:$version || exit 1
fi
docker push $repo/$image:$version
