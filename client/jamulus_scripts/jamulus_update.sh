#!/bin/bash

cd /home/pi/
sudo chown -R pi:pi jamulus/
cd jamulus
echo "____ Getting latest version from repo..."
git pull
# TODO: check if there was an update
echo "____ Compiling..."
# do the compile stuff. Maybe with jamulus raspi script

