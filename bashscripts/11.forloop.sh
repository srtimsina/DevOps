#!/bin/bash
set -x
USERS="bipin suryaraj1 utsav1 ashim"
for user in $USERS
do
	echo "Adding $user in this machine..."
	useradd $user
	id $user
	echo "User added"
done

