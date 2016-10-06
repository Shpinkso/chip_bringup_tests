#!/bin/bash
#Script clears all evidence of us having sullied the board
BOARDS=${1:-15}
FIRSTIP=3
LOCALFILE=~/blankrclocal/rc.local
REMOTEDIR=/etc
USER=root
IPADDRPREF="192.168.1."

for i in $(seq 1 $BOARDS); do
    k=$(($i+2))
    # overwrite rc.local
    scp $LOCALFILE $USER@$IPADDRPREF$k:$REMOTEDIR
    # ssh in - assumes that known hosts is already populated
    ssh $USER@$IPADDRPREF$k <<'ENDSSH'
    rm /results_*
    sync
ENDSSH
done
