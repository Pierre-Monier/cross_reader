#!/bin/sh
# Move test files to the connected device

if ! command -v adb &> /dev/null
then
    echo "adb could not be found"
    exit
fi

echo "moving all files from test_ressources into to connected device..."
# it takes all the files in the test_ressources folder and moves them to the connected device   
adb push test_ressources/* /storage/emulated/0/Documents/
echo "done :)"