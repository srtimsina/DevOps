#!/bin/bash
#this is is build script to create docker image.
pwd
whoami
cd /docker/docker-examples
whoami
sudo docker ps
docker build -t localimg:$BUILD_NUMBER .
