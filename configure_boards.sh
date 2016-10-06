#!/bin/bash
# Script is run once and assumes that the target boards are on and ready
# Default 15 boards if no first arg
BOARDS=${1:-15}
# Default to /tmp/script if no second arg
SCRIPT=${2:-~/rc.local}
IPADDRPREF="192.168.1."
REMOTEDIR=${3:-/etc}
REMOTESCRIPT=$REMOTEDIR/${SCRIPT##*/}
USER=root

for i in $(seq 1 $BOARDS); do
    k=$(($i+2))
    # Prevent RSA key question
    ssh-keyscan -H $IPADDRPREF$k >> ~/.ssh/known_hosts
    # Copy the script to the device
    scp $SCRIPT $USER@$IPADDRPREF$k:$REMOTEDIR
    # ssh $USER@$IPADDRPREF$k
done

