#!/bin/bash

echo "Please execute this all Raspberry PIs. Press any key to continue or ctrl+c to abort"
read -n 1
# check if general-config file exists
if [[ ! -f "config/general-config.conf" ]]
  then
    echo "ERROR: Could not find general-config.conf file. Please create one in config/general-config.conf. See config/general-config.conf.example for example."
    exit 1
fi
# set version of rasJam to be installed
rasJamVersion=$(cat config/rasjamversion)

# install and download dependencies
# apt update && apt full-upgrade -y
# apt install -y openssh-server git jackd qt5-default qttools5-dev qt5-default qttools5-dev-tools libjack-libjackd2-dev

# get devices from folder in devices which were already setup
# if the devices list is empty, we need don't have any port numbers set. Set the default port number.
# https://askubuntu.com/questions/1147681/how-to-pass-a-regex-when-finding-a-directory-path-in-bash
for dir in devices/*/
do
  if [[ ${dir} =~ "rasjam_" ]]
  then
    break
  fi
done
if ((${#BASH_REMATCH[@]} > 0))
  then # directories exist
    devicesList=$(ls -d devices/rasjam_*)
    # generate ssh port
    # get all ports and sort them
    ports=$(cat devices/rasjam_*/ssh-port-bind.txt | sort -V)
    # get the last (= highest port in list)
    port=$(echo $ports | grep -oE '[^ ]+$')
    port=$((++port))
  else
    echo "Newly creating device folder. This is probably the first run."
    devicesList=''
    port=50000
fi
# the hostname will be rasjam_${port}
hostname="rasjam_${port}"

# make a device folder
folderName=devices/${hostname}
echo "Making directory ${folderName}..."
if [ ! -d "${folderName}" ]
  then
    mkdir ${folderName}
  else
    echo "FATAL ERROR: ${folderName} already exists. Something went wrong. This should never happen."
    exit 1
fi

# echo the port into the file
echo "New port for reverse ssh will be:"
echo ${port}
echo ${port} > ${folderName}/ssh-port-bind.txt

# set hostname
echo "Setting hostname to ${hostname}..."
echo "Old hostname:"
hostname
hostname -b ${hostname}
echo "New hostname:"
hostname

# copy config files
echo "Copying config files to Raspberry Pi..."
# make config folder
mkdir /etc/rasjam
# copy the port name to a file
echo ${port} > /etc/rasjam/remote-access-port.config
# general config file for all pis (mainly including server IPs)
cp config/general-config.conf /etc/rasjam/general-config.conf
# for the keys
mkdir /etc/rasjam/ssh
# for the rasjam version
echo ${rasJamVersion} > /etc/rasjam/rasjamversion
# Regenerate ssh-keys
echo "Regenerating ssh-keys..."
systemctl enable sshd
rm /etc/ssh/ssh_host_*
dpkg-reconfigure openssh-server
systemctl restart sshd
su pi -c "ssh-keygen -q -t ed25519 -f ~/.ssh/pi_sshkey -N '' <<< ""$'\n'"y" 2>&1 >/dev/null"

echo "Copying new ssh-keys to ${folderName}/ssh/"
# get the ssh keys of this device
mkdir ${folderName}/ssh/
cp /etc/ssh/*.pub ${folderName}/ssh/
cp /home/pi/.ssh/pi_sshkey.pub ${folderName}/ssh/pi_sshkey.pub

echo "Set new password for pi"
# generate a random password for pi
pw=`head /dev/hwrng | tr -dc A-Za-z0-9 | head -c 156`
echo "Saving password..."
echo ${pw} > ${folderName}/pw.txt
#set password
echo "Setting password..."
echo -e "${pw}\n${pw}" | passwd pi

echo "Enabling maximal cpu performance..."
cp files/systemd/jaminst_cpugov_set_performance.service /etc/systemd/system/
# disable auto governor set via raspi-config service
systemctl disable raspi-config
systemctl start jaminst_cpugov_set_performance.service
systemctl enable jaminst_cpugov_set_performance.service

echo "Disabling WIFI and Bluetooth.."
#Disable BT and Wifi
echo "dtoverlay=disable-bt" >> /boot/config.txt
echo "dtoverlay=disable-wifi" >> /boot/config.txt
# disable bluetooth modems conn by uart (blog.sleeplessbeastie.eu)
systemctl disable hciuart
# remove bt
apt remove bluez triggerhappy avahi-daemon -y
apt autoremove

echo "Add pi to audio group..."
adduser pi audio

# copy the jamulus binary
echo "Copying Jamulus binary"

#cp files/Jamulus/Jamulus/ /usr/local/bin/
# done for now; TODO: Auto boot to jamulus. How can we access the settings/...
