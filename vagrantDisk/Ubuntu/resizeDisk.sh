#!/bin/bash

echo "Expanding disk..."
ROOR_DISK_TO_EXPAND="/dev/sda"
ROOT_DISK_DEVICE_PART="/dev/sda1"
LV_PATH=`sudo lvdisplay -c | sed -n 1p | awk -F ":" '{print $1;}'`
FS_PATH=`df / | sed -n 2p | awk '{print $1;}'`
ROOT_FS_SIZE=`wr`
echo "The root file system (/) has a size of $ROOT_FS_SIZE"
echo "> Increasing disk size of $ROOR_DISK_TO_EXPAND to available maximum"
sudo fdisk $ROOR_DISK_TO_EXPAND <<EOF
d 
n
p
1
2048

no
w
EOF
sudo pvresize $ROOT_DISK_DEVICE_PART
sudo lvextend -l +100%FREE $LV_PATH
sudo resize2fs -p $FS_PATH
ROOT_FS_SIZE=`df -h / | sed -n 2p | awk '{print $2;}'`
echo "The root file system (/) has a size of $ROOT_FS_SIZE"
echo "*****************************************************"
echo "Disk seems to be expanded"
echo "Run vagrant ssh to login the vm and check disk status"