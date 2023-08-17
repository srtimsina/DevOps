#!/bin/bash
set -x
A=surya

if [ $A -gt 5 ];
then
	echo "The number is greater than 5"
elif [ $A -lt 5 ];
then
	echo "The number is less than 5"
else
	echo "The number is equal 5"
fi
