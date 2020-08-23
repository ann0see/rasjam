#!/bin/bash
#### THIS SCRIPT CONNECTS TO A REMOTE API AND CHECKS FOR UPDATES ####

echo "Starting update..."
# integrate api
source /etc/rasjam/general-config.conf
# login
# send rasjam version
rasJamVersion=$(cat /etc/rasjam/rasjamversion)
# get api response
apiResponse=$(curl ${api_server_api_url})
# check cases
# get update.sh.tar.gz
# get update.sh.tar.gz.asc
# verify signature
# execute update.sh
