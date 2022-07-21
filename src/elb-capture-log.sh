#!/bin/bash

# Set env
source .env

# Logging
echo "[$(date +"%Y-%m-%dT%H:%M:%S%z")] STOPPED CAPTURE SERVICE" >> $LOGFILE

# Remove oldest file
$POSTROTATESCRIPT
