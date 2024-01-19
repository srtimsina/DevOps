# integrate below commands directly in add step -> execute shell command . 
# if you want execute this script directly then run sh runcontainer.sh and if you wish pass environment variable as $BUILD_NUMBER or $BUILD_ID as arg for using to make 
# image and container name.
#!/bin/bash
whoami #no need ,just for knowing the user
docker ps -a
APP_NAME=my-app
#note: if these commands were executed from bash script then we may have passed the $BUILD_NUMBER as arg
#that would have been catched using BUILD_NUMBER=$1 and later used for tagging the image
#since here we are directly incorporating commands i have explicitly given the app name and version for tag.
APP_VERSION=latest
#the below line hav python script integrated to find free port to allocate for container.
free_port=$(python3 -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1]); s.close()')
# below we could have used rand port using -P flag and run docker ps -a to list all container along with port.
docker run --rm -d -p $free_port:3000 "$APP_NAME:$APP_VERSION"
echo "Container running on port: $free_port"
