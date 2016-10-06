#!/bin/bash
# Script is run once and assumes that the target boards are on and ready
# Default 15 boards if no first arg
BOARDS=${1:-15}
# Default to /tmp/script if no second arg
SCRIPT=${2:-/tmp/script}
IPADDRPREF="172.17.0."
REMOTEDIR=${3:-/data}
REMOTESCRIPT=$REMOTEDIR/${SCRIPT##*/}
USER=root
PASSWD=root
for i in `seq 1 $BOARDS`; do
    # Allow ssh/scp to login without passwd
    sshpass -p $PASSWD ssh-copy-id $USER@$IPADDRPREF$i
    # Prevent RSA key question
    ssh-keyscan -H $IPADDRPREF$i >> ~/.ssh/known_hosts
    # Copy the script to the device
    scp $SCRIPT $USER@$IPADDRPREF$i:$REMOTEDIR
    # Get rc.local to run this script on the device
    echo $REMOTESCRIPT | ssh $USER@$IPADDRPREF$i 'cat >> /etc/rc.local'
done

