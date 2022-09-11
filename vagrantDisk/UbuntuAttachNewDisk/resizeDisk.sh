#!/bin/bash

echo "Configuring LVM..."
ROOR_DISK_TO_EXPAND="/dev/sdc"
ROOT_DISK_DEVICE_PART="/dev/sdc1"
#LV_PATH=`sudo lvdisplay -c | sed -n 1p | awk -F ":" '{print $1;}'`
#FS_PATH=`df / | sed -n 2p | awk '{print $1;}'`
sudo fdisk $ROOR_DISK_TO_EXPAND <<EOF 
n
p
1
2048
+5G
t
8e
w
EOF
sudo pvcreate $ROOT_DISK_DEVICE_PART
sudo vgcreate vg0 $ROOT_DISK_DEVICE_PART
sudo lvcreate -L +4G vg0 -n lv0
sudo mkfs -t ext4 /dev/vg0/lv0
sudo mkdir /data
str=$(blkid | grep vg0 | awk '{print $2}')
str1="$str  /data   ext4    defaults    0   2"
echo "$str1" >> /etc/fstab
sudo mount -a
echo "*****************************************************"
echo "LVM created and configured"



echo "Expanding the remaining size..."
sudo fdisk $ROOR_DISK_TO_EXPAND <<EOF 
n
p
2


t
2
8e
w
EOF
sudo pvcreate /dev/sdc2
sudo vgextend vg0 /dev/sdc2
sudo lvextend -L +5G /dev/vg0/lv0
sudo lvdisplay /dev/vg0/lv0
sudo df -h
sudo blkid /dev/vg0/lv0
sudo resize2fs /dev/vg0/lv0
sudo df -h
echo "Disk has been resized"
echo "Run vagrant ssh to login the vm and check disk status"