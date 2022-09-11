#!/bin/bash

echo "Expanding disk"

ROOR_DISK_TO_EXPAND="/dev/sda"
ROOT_DISK_DEVICE_PART="/dev/sda2"
LV_PATH=`sudo lvdisplay -c | sed -n 2p | awk -F ":" '{print $1;}'`
FS_PATH=`df / | sed -n 2p | awk '{print $1;}'`
ROOT_FS_SIZE=`wr`
echo "The root file system (/) has a size of $ROOT_FS_SIZE"
echo "> Increasing disk size of $ROOR_DISK_TO_EXPAND to available maximum"
sudo fdisk $ROOR_DISK_TO_EXPAND <<EOF
d
2
n
p
2


no
w
EOF
sudo pvresize $ROOT_DISK_DEVICE_PART
sudo lvextend -l +100%FREE $LV_PATH
/usr/sbin/partprobe
/usr/sbin/xfs_growfs -d $FS_PATH
ROOT_FS_SIZE=`df -h / | sed -n 2p | awk '{print $2;}'`
echo "*****************************************************"
echo "Disk seems to be expanded"
echo "The root file system (/) has a size of $ROOT_FS_SIZE"
echo "Run vagrant ssh to login the vm and check disk status"