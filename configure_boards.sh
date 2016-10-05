#!/bin/bash
# Script is run once and assumes that the target boards are on and ready
# Default 15 boards if no first arg
BOARDS=${1:-15}
# Default to /tmp/script if no second arg
SCRIPT=${2:-/tmp/script}
IPADDRPREF="192.168.0."
REMOTEDIR=${3:-/data}
REMOTESCRIPT=$REMOTEDIR/${SCRIPT##*/}
for i in `seq 1 $BOARDS`; do
    scp $SCRIPT root@$IPADDRPREF$i:$REMOTEDIR
    echo $REMOTESCRIPT | ssh $IPADDRPREF$i 'cat >> /etc/rc.local'
done

