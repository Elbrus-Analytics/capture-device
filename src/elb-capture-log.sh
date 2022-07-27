#!/bin/bash
cd "$(dirname "$(readlink -f "$0")")"

# Set env
source .env

# Logging
echo "[$(date +"%Y-%m-%dT%H:%M:%S%z")] STOPPED CAPTURE SERVICE" >> "$LOGFILEDIR/capture-$(date +"%Y-%U").log"

# Remove oldest file
$POSTROTATESCRIPT
