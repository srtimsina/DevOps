#!/bin/bash

if [ -f "/var/run/apache2/apache2.pid" ];
then
	echo "The apache service is running"
else
	echo "The apache service is not running"
	sudo systemctl start apache2
fi
