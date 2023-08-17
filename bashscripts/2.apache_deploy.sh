#!/bin/bash

echo "We are installing apache"
sudo apt-get update >> /var/log/myapp.log
sudo apt-get install apache2 unzip -y >> /var/log/myapp.log
mkdir /tmp/mydir
cd /tmp/mydir
wget -q https://www.tooplate.com/zip-templates/2135_mini_finance.zip
unzip 2135_mini_finance.zip >> /var/log/myapp.log
cp -r 2135_mini_finance/* /var/www/html/
sudo systemctl status apache2
sudo systemctl start apache2
rm -r /tmp/mydir

