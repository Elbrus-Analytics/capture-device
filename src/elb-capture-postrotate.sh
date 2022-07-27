#!/bin/bash

# Set env
cd "$(dirname "$(readlink -f "$0")")"
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
if [ $IMPORTERPATH ]; then
cd "$(dirname "$IMPORTERPATH")"
echo "[$(date +"%Y-%m-%dT%H:%M:%S%z")] starting import ..." >> "$LOGFILEDIR/capture-$(date +"%Y-%U").log"
$IMPORTERPATH >> "$LOGFILEDIR/capture-$(date +"%Y-%U").log"
echo "[$(date +"%Y-%m-%dT%H:%M:%S%z")] finished import" >> "$LOGFILEDIR/capture-$(date +"%Y-%U").log"
fi

if [ $REPORTERPATH ]; then
cd "$(dirname "$REPORTERPATH")"
echo "[$(date +"%Y-%m-%dT%H:%M:%S%z")] creating report ..." >> "$LOGFILEDIR/capture-$(date +"%Y-%U").log"
python3 $REPORTERPATH
fi