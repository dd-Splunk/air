#!/bin/bash
DIMS="#board_id:123abc,board_type:MKR1100,sensor_type:MKRENV"
while [ true ]
do
  TEMP=$((15 + $RANDOM % 10))
  HUMI=$((45 + $RANDOM % 20))
  echo "air.temperature:$TEMP|g|$DIMS" | nc -w 1 localhost 8125
  echo "air.humidity:$HUMI|g|$DIMS" | nc -w 1 localhost 8125
  echo -n "."
  sleep 145s
done
