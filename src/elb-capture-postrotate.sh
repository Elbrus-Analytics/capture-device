#!/bin/bash

# Set env
source .env

# Remove oldest file
while true; do
  if [ $( ls -t $PCAP | grep -E 'trace.*\.pcap' | wc -l ) -gt $MAXFILES ]; then
  	FILE=$PCAP"$(ls -t $PCAP | grep -E 'trace.*\.pcap' | tail -1)"
  	rm $FILE
  	echo "[$(date +"%Y-%m-%dT%H:%M:%S%z")] DELETED $FILE" >> $LOGFILE
  else
    break
  fi
done
