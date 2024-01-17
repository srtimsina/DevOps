#!/bin/bash
#this is is build script to create docker image.
# Print basic information
pwd
whoami
echo $HOME
pwd
#cd docker/docker-examples
# Define variables
APP_NAME="my-app"
BUILD_NUMBER="$1"

# Build the Docker image
docker build -t "$APP_NAME:$BUILD_NUMBER" . -f Dockerfile
