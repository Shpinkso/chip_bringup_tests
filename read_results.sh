#!/bin/bash

BOARDS=${1:-15}
IPADDRPREF="192.168.1."

TIME=$(date +%T)
DATE=$(date +%y-%m-%d)

mkdir -p ~/$DATE.$TIME/

for i in $(seq 1 $BOARDS); do
	k=$(($i+2))
	scp root@$IPADDRPREF$k:/results_* ~/$DATE.$TIME/
done
