#!/bin/bash

NODE=$1
NODE_ADDRESS=$(./get_address.sh $NODE)
./provenance.sh $NODE q staking delegations $NODE_ADDRESS --home ./node$NODE -t | sed -n '9 p' | awk '{print substr($2, 0, length($2)-1)}' -