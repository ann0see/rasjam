#!/bin/bash

# install and download dependencies
apt update && apt full-upgrade -y
apt install -y xorg git idesk openbox obmenu qjackctl jackd build-essential qtdeclarative5-dev qt5-default qttools5-dev qt5-default qttools5-dev-tools libjack-libjackd2-dev
# copy config files
cp -r /home/pi/jaminst/files/openbox/* /home/pi/.config/openbox/
cp -r /home/pi/jaminst/files/idesktop /home/pi/.idesktop
# copy scripts
mkdir /home/pi/jamulus_scripts
cp /home/pi/jaminst/jamulus_scripts/jamulus_update.sh /home/pi/jamulus_scripts/jamulus_update.sh

cp /home/pi/jaminst/files/systemd/jaminst_cpugov_set_performance.service /etc/systemd/system/
# disable auto governor set via raspi-config service
systemctl disable raspi-config
systemctl start jaminst_cpugov_set_performance.service
systemctl enable jaminst_cpugov_set_performance.service
# add pi to the audio group
adduser pi audio
#Disable BT and Wifi
echo "dtoverlay=disable-bt" >> /boot/config.txt
echo "dtoverlay=disable-wifi" >> /boot/config.txt
# disable bluetooth modems conn by uart (blog.sleeplessbeastie.eu)
systemctl disable hciuart
# remove bt
apt remove bluez -y
# set automatic boot to openbox


# install jamulus
cd /home/pi

git clone https://github.com/corrados/jamulus.git

sh /home/pi/jamulus_scripts/jamulus_update.sh

# done for now
