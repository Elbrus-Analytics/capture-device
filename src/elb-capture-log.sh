#!/bin/bash

# Set env
source .env

# Logging
echo "[$(date +"%Y-%m-%dT%H:%M:%S%z")] STOPPED CAPTURE SERVICE" >> "$LOGFILEDIR/capture-$(date +"%Y-%U").log"

# Remove oldest file
$POSTROTATESCRIPT
