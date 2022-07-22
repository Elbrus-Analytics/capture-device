#!/bin/bash

# Set env
source .env
source $SHAREDCONFIG

# Remove oldest file
while true; do
  if [ $( ls -t $PCAPFOLDER | grep -E 'trace.*\.pcap' | wc -l ) -gt $MAXFILES ]; then
  	FILE=$PCAPFOLDER/"$(ls -t $PCAPFOLDER | grep -E 'trace.*\.pcap' | tail -1)"
  	rm $FILE
  	echo "[$(date +"%Y-%m-%dT%H:%M:%S%z")] DELETED $FILE" >> "$LOGFILEDIR/capture-$(date +"%Y-%U").log"
  else
    break
  fi
done

sleep 1
echo "[$(date +"%Y-%m-%dT%H:%M:%S%z")] starting import ..." >> "$LOGFILEDIR/capture-$(date +"%Y-%U").log"
$IMPORTERPATH
echo "[$(date +"%Y-%m-%dT%H:%M:%S%z")] finished import" >> "$LOGFILEDIR/capture-$(date +"%Y-%U").log"