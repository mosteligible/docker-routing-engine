#!/bin/bash

usage() (
cat <<USAGE
Build a docker image for GraphHopper and optionally push it to Docker Hub

Usage:
  ./build.sh [[--push] <tag>]
  ./build.sh --help

Argument:
  <tag>         Build an image for the given routing-engine repository tag [default: master]

Option:
  --push        Push the image to Docker Hub
  --help        Print this message
  
Docker Hub credentials are needed for pushing the image. If they are not provided using the
DOCKERHUB_USER and DOCKERHUB_TOKEN environment variables, then they will be asked interactively.
USAGE
)

if [ "$1" == "--push" ]; then
  push="true"
  docker login --username "${DOCKERHUB_USER}" --password "${DOCKERHUB_TOKEN}" || exit $?
  shift
else
  push="false"
fi

if [ $# -gt 1 ] || [ "$1" == "--help" ]; then
  usage
  exit
fi

if [ ! -d "routing-engine" ]; then
  echo "Cloning routime-engine"
  git clone https://github.com/mosteligible/routing-engine.git
else
  echo "Pulling routing-engine"
  (cd routing-engine; git checkout master; git pull)
fi

imagename="routing-engine:${1:-latest}"
if [ "$1" ]; then
  echo "Checking out routing-engine:$1"
  (cd routing-engine; git checkout --detach "$1")
fi

echo "Building docker image ${imagename}"
docker build . -t "${imagename}"

sudo rm -rf routing-engine
