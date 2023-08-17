#!/bin/bash

echo "Hello $name"
echo "We are installing apache"
packages="apache2 unzip"
wdir="/tmp/mynewdir"
URL="https://www.tooplate.com/zip-templates"
fileName="2135_mini_finance"
dest_dir="/var/www/html/"
log_path="/var/log/myappnew.log"

sudo apt-get update >> $log_path
echo "Installing dependencies..."
sudo apt-get install $packages -y >> $log_path
mkdir $wdir
cd $wdir
echo "Downloading $fileName.zip"
wget -q $URL/$fileName.zip
unzip $fileName.zip >> $log_path
cp -r $fileName/* $dest_dir/
sudo systemctl status apache2
echo "Restarting apache service"
sudo systemctl restart apache2
rm -r $wdir

