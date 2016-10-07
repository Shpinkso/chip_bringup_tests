#!/bin/bash

BOARDS=${1:-15}
IPADDRPREF="192.168.1."
NC='\033[0m'
BLUE='\033[0;34m'
GREEN='\033[0;32m'
LCYAN='\033[1;36m'

TIME=$(date +%T)
DATE=$(date +%y-%m-%d)

mkdir -p ~/$DATE.$TIME/

for i in $(seq 1 $BOARDS); do
	k=$(($i+2))
	scp root@$IPADDRPREF$k:/results_* ~/$DATE.$TIME/
done

FOLDER=${2:-~/$DATE.$TIME}

FILES=$FOLDER/*

for f in $FILES
do
  echo "Processing ${f##*/} file..."
  # take action on each file. $f store current file name

  PASS=$(cat $FOLDER/${f##*/} | grep -c lowpan0)
  FAIL=$(cat $FOLDER/${f##*/} | grep -c fail)

  echo pass=$PASS fail=$FAIL

  TOTAL=$(( $PASS+$FAIL ))

  VAR=$(echo "scale=2; $FAIL/$TOTAL" | bc)

  FINAL=$(echo "scale=2; $VAR*100" | bc)

  echo -e "${LCYAN}$FINAL%${NC}"

#  LIMIT=10

#  if [ "$FINAL" -ge "$LIMIT" ]
#    then
#      echo -e "${RED}$FINAL%{NC}"
#    else
#      echo -e "${GREEN}$FINAL%{NC}"
#  fi

done

