#!/bin/bash

# Input
NODE=$1

ADDRESS=$(./get_address.sh $NODE)

./provenance.sh $NODE q bank balances $ADDRESS \
--home ./node$NODE \
-t \
--chain-id "chain-local"