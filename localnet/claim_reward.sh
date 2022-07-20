#!/bin/bash

# Input
NODE=$1
ID=$2

ADDRESS=$(./get_address.sh $NODE)

./reward_program.sh $NODE claim-reward $ID \
--home ./node$NODE \
-t \
--chain-id "chain-local" \
--gas auto \
--gas-adjustment 1.5 \
--gas-prices 1905nhash \
--from $ADDRESS \
-y