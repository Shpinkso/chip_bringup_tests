#!/bin/bash
#Script clears all evidence of us having sullied the board
BOARDS=${1:-15}
FIRSTIP=3
LOCALFILE=~/rc.local
REMOTEDIR=/etc
USER=root
IPADDRPREF=192.168.0.
for i in `seq $FIRSTIP ($BOARDS + $FIRSTIP)`; do
    # overwrite rc.local
    scp $LOCALFILE $USER@$IPADDRPREF$i:$REMOTEDIR
    # ssh in - assumes that known hosts is already populated
    ssh $USER@$IPADDRPREF$i
    # Remove log files
    rm /results_*
    sync
    # exit out of ssh
    exit 
done

