#!/bin/bash

# Set env
source .env

# Logging
echo "[$(date +"%Y-%m-%dT%H:%M:%S%z")] STARTED CAPTURE SERVICE" >> $LOGFILE

# Create folders
mkdir -p /var/elbrus/capture/pcap

# Run tcpdump
tcpdump -i $INTERFACE -w $PCAP/trace-%Y-%m-%d-%H-%M-%S.pcap -G $TIMEPERCAPTURE -z $POSTROTATEPATH -K -n
