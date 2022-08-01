#!/bin/bash

# Input
NODE=$1
PROGRAM_ID=$2

ADDRESS=$(./get_address.sh $NODE)

./provenance.sh $NODE tx reward end-reward-program $PROGRAM_ID \
--home ./node$NODE \
-t \
--chain-id "chain-local" \
--gas auto \
--gas-adjustment 1.5 \
--gas-prices 1905nhash \
--from $ADDRESS \
-y