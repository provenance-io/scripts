#!/bin/bash

# Input
NODE=$1
ARG=$2

ADDRESS=$(./get_address.sh $NODE)

./reward_program.sh $NODE reward-program $ARG \
--home ./node$NODE \
-t \
--chain-id "chain-local"