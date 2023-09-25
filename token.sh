#!/bin/bash
source .env
#
# Enable Token Admin
curl -k -s -u admin:$SPLUNK_PASSWORD -X POST https://$SPLUNK_HOST:8089/services/admin/token-auth/tokens_auth -d disabled=false
# Create Token
curl -k -s -u admin:$SPLUNK_PASSWORD -X POST https://$SPLUNK_HOST:8089/services/authorization/tokens?output_mode=json --data name=admin --data audience=Admins | jq '.entry[0].content.token'
