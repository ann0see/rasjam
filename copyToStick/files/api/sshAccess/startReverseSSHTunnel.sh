#!/bin/bash
#### THIS SCRIPT ENABLES A REVERSE SSH TUNNEL ####

# get the general config file
source /etc/rasjam/general-config.conf
port=$(cat /etc/rasjam/remote-access-port.config)
# ATTENTION: this might be dangerous: we add a foreign ssh signature as trusted here
if [[ ! -f "/etc/rasjam/ssh/key_saved" ]]
  then
    echo "/etc/rasjam/ssh/key_saved doesn't exist yet. Assuming this is the first connection test"
    ssh-keyscan -p${api_server_ssh_port} -H ${api_server} >> /home/pi/.ssh/known_hosts
    touch /etc/rasjam/ssh/key_saved
fi
echo "Starting Reverse ssh tunnel to ${api_server} on port ${api_server_ssh_port}"
# we could use autossh one day
ssh -p${api_server_ssh_port} -R ${port}:localhost:${local_pi_ssh_port} ${api_server_user_name}@${api_server} -i /home/pi/.ssh/pi_sshkey
