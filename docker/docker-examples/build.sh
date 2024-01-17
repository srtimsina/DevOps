#!/bin/bash
#this is is build script to create docker image.
pwd
whoami
docker ps
docker build -t localimg:$BUILD_NUMBER .
