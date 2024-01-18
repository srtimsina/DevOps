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
BUILD_NUMBER="$1"  #environment varibale that denotes built number.

# cleans up all unused images, containers, networks, and volumes, effectively clearing the cache before build
#use with caution and only if neccessary
docker system prune -a --volumes

# Build the Docker image
# --no-cache flag explicitly instructs Docker to ignore any cached layers and build all layers from the beginning.
docker build --no-cache -t "$APP_NAME:$BUILD_NUMBER" . -f Dockerfile
