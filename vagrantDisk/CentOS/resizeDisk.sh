#!/bin/bash

echo "Expanding disk...."

ROOR_DISK_TO_EXPAND="/dev/sda"
sudo fdisk $ROOR_DISK_TO_EXPAND <<EOF
p
d 
n
p
1
2048

w
EOF
/usr/sbin/partprobe
/usr/sbin/xfs_growfs -d / 
df -h /
echo "*****************************************************"
echo "Disk seems to be expanded"
echo "Run vagrant ssh to login the vm and check disk status"