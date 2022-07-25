#!/bin/bash

# Input
NODE=$1
PROPOSAL=$2
shift
shift
ARGS=$@

ADDRESS=$(./get_address.sh $NODE)

./provenance.sh $NODE tx gov vote $PROPOSAL yes $@ \
--home ./node$NODE \
-t \
--chain-id "chain-local" \
--gas auto \
--gas-adjustment 1.5 \
--gas-prices 1905nhash \
--from $ADDRESS \
-y