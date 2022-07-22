#!/bin/bash

# Set env
source .env
source $SHAREDCONFIG

# Logging
echo "[$(date +"%Y-%m-%dT%H:%M:%S%z")] STARTED CAPTURE SERVICE" >> "$LOGFILEDIR/capture-$(date +"%Y-%U").log"

# Create folders
mkdir -p $PCAPFOLDER

# Run tcpdump
tcpdump -i $INTERFACE -w $PCAPFOLDER/trace-%Y-%m-%d-%H-%M-%S.pcap -G $TIMEPERCAPTURE -z $POSTROTATESCRIPT -K -n
