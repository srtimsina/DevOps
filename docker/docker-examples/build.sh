#!/bin/bash
#this is is build script to create docker image.
# Print basic information
pwd
whoami
docker ps

# Define variables
APP_NAME="my-app"
BUILD_NUMBER="$1"

# Build the Docker image
docker build -t "$APP_NAME:$BUILD_NUMBER" . -f Dockerfile
