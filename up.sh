#!/bin/bash
source .env
# Bring up the environment
docker compose up -d

echo "Wait for Splunk availability"

REGEX="<sessionKey>(.+)<\/sessionKey>"
until [[ "$(curl -k -s -u admin:$SPLUNK_PASSWORD https://$SPLUNK_HOST:8089/services/auth/login -d username=admin -d password=$SPLUNK_PASSWORD)" =~ $REGEX ]]; do
  echo -n '.'
  sleep 10
done
# https://stackoverflow.com/questions/1891797/capturing-groups-from-a-grep-regex
sessionKey=${BASH_REMATCH[1]}
