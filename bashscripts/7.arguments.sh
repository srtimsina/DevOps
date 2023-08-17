#!/bin/bash

echo "We are now learning argument in script"
# Print the 0th place argument, the default value is the path to the script itself.
echo "The 0th place argument is $0"
# Print the 1st place argument
echo "The first place argument is $1"
# List all the arguments passed
echo "The aruments passed are $@"
# Count and print the number of arguments passed
echo "The number of argument passed is $#"
# Print the second place argument
echo "The 2nd place arguemtn is $2"
# Print the number of arguments passed."
echo "The number of arugment is $$"
# Print the hostname of the system
echo "The hostname of the machine is $HOSTNAME"
# Print the name of the user currently logging in.
echo "The current user is $USER"
# Print the line number of the script
echo "The line number is $LINENO"
# Sleep 5 seconds
sleep 5s
# Print the time taken to run scripts till now.
echo "The time taken by the process is $SECONDS"
# Generate some random number
echo "Random number $RANDOM"
echo "Date"
date
# Print the exit code of last command. In this case date
echo "Exit code of last command is $?"
