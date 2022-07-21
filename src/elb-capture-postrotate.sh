#!/bin/bash

# Set env
source .env

# Remove oldest file form DIR "/var/elbrus/capture/pcap/"
if [ $( ls $PCAP | wc -l ) -gt $MAXFILES ]; then
	FILE=$PCAP"$(ls -t $PCAP | tail -1)"
	rm $FILE
	echo "[$(date +"%Y-%m-%dT%H:%M:%S%z")] DELETED $FILE" >> $LOGFILE
fi
