#!/bin/bash

counter=0

while [ $counter -lt 5 ]
do
	echo "We are insde loop..."
	echo "Value of counter is $counter"
	counter=$((counter+1))
	sleep 2
done
echo "We are done with the while loop. Now outside the loop."
