#!/bin/bash

# Input
NODE=$1
ARG=$2

ADDRESS=$(./get_address.sh $NODE)

./reward_program.sh $NODE claim-period-reward-distribution $ARG \
--home ./node$NODE \
-t \
--chain-id "chain-local"