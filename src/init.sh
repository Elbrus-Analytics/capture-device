#!/bin/bash
while true; do
read -p "Do you want to proceed with setup of the 'capture-device'? (y/n) " yn
case $yn in
    [yY] | "yes" | "Yes" ) break;;
    [nN] | "no" | "No" ) echo exiting...;
            exit;;
    * ) echo invalid response;;
esac
done
echo
sleep 0.25

SHAREDCONFIG=/var/elbrus/shared/.config
POSTROTATEPATH=/var/elbrus/capture/elb-capture-postrotate.sh
LOGPATH=/var/elbrus/shared/log
read -p "Where should the log be stored (dir) [$LOGPATH]: " LOGPATH
read -p "Where is the elb-capture-postrotate.sh stored [$POSTROTATEPATH]: " POSTROTATEPATH
read -p "Where is the shared config stored [$SHAREDCONFIG]: " SHAREDCONFIG
SHAREDCONFIG=${SHAREDCONFIG:-/var/elbrus/shared/.config}
POSTROTATEPATH=${POSTROTATEPATH:-/var/elbrus/capture/elb-capture-postrotate.sh}
LOGPATH=${LOGPATH:-/var/elbrus/shared/log}


while true; do
echo 
echo "Should the log be stored at '$LOGPATH' ?"
echo "Is the 'elb-capture-postrotate.sh' stored at '$POSTROTATEPATH' ?"
read -p "Is the shared config stored at '$SHAREDCONFIG' ? (y/n/exit) " confirm
case $confirm in
    [yY] | "yes" | "Yes" ) break;;
    [nN] | "no" | "No" ) clear;
            read -p "Where should the log be stored (dir) [/var/elbrus/capture/]: " LOGPATH;
            read -p "Where is the elb-capture-postrotate.sh stored [$POSTROTATEPATH]: " POSTROTATEPATH;
            read -p "Where is the shared config stored [$SHAREDCONFIG]: " SHAREDCONFIG;
            SHAREDCONFIG=${SHAREDCONFIG:-/var/elbrus/shared/.config};
            POSTROTATEPATH=${POSTROTATEPATH:-/var/elbrus/capture/elb-capture-postrotate.sh};
            LOGPATH=${LOGPATH:-/var/elbrus/capture/};;
    [eE] | "exit" | "Exit" ) echo exiting...;
            exit;;
    * ) echo invalid response;;
esac
done


mkdir -p $LOGPATH

tee .env <<EOL
#global
SHAREDCONFIG=$SHAREDCONFIG

#paths
POSTROTATESCRIPT=$POSTROTATEPATH
LOGFILEDIR=$LOGPATH

#settings
TIMEPERCAPTURE=900
MAXFILES=10
INTERFACE=eth0 
EOL

echo "Cleaning up..."
rm -rf $(readlink -f "${BASH_SOURCE:-$0}")
