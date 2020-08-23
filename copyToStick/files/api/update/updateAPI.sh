#!/bin/bash
#### THIS SCRIPT CONNECTS TO A REMOTE API AND CHECKS FOR UPDATES ####

echo "Starting update..."
# integrate api
source /etc/rasjam/general-config.conf
apiResponse=$(curl ${api_server_api_url})
