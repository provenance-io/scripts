#!/bin/bash

# Input
NODE=$1

ADDRESS=$(./get_address.sh $NODE)

./provenance.sh $NODE q staking delegations $ADDRESS \
--home ./node$NODE \
-t \
--chain-id "chain-local"