#!/bin/bash

myfilecontent=`cat ./myfile.txt`
echo $myfilecontent

echo "Another approach"
fileContents=$(cat ./myfile.txt)
echo "The contents of file is \n $fileContents"
