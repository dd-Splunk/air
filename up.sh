#!/bin/bash
source .env
# Bring up the environment
docker compose up -d

echo "Wait for Splunk availability"
until [ $(docker inspect --format='{{.State.Health.Status}}' so1) = healthy ]
do
  echo -n '.'
  sleep 10
done

echo -e "\nChange App $SPLUNK_APP permission to Global"
until $(curl -s -f -o /dev/null -k -u admin:$SPLUNK_PASSWORD --request POST "https://$SPLUNK_HOST:8089/services/apps/local/$SPLUNK_APP/acl" -d sharing=global -d owner=nobody)
do
  echo -n '.'
  sleep 10
done

echo -e "\nEnable EventGen"
until $(curl -s -f -o /dev/null -k -u admin:$SPLUNK_PASSWORD --request POST "https://$SPLUNK_HOST:8089/servicesNS/nobody/SA-Eventgen/data/inputs/modinput_eventgen/default/enable")
do
  echo -n '.'
  sleep 10
done

echo -e "\nWait for login prompt"
until $(curl -s -f -o /dev/null -k --head "http://$SPLUNK_HOST:8000")
do
  echo -n '.'
  sleep 10
done

echo -e "\nUp and Running."