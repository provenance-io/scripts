#!/bin/bash

NODE=$1
CMD=$2
shift

# We can either create or query
# add-reward-program
# claim-reward
# reward-program
# epoch-reward-distribution

TYPE="tx"
if [[ "$CMD" == "add-reward-program" ]]; then
    TYPE="tx"
elif [[ "$CMD" == "claim-reward" ]]; then
    TYPE="tx"
elif [[ "$CMD" == "reward-program" ]]; then
    TYPE="q"
elif [[ "$CMD" == "claim-period-reward-distribution" ]]; then
    TYPE="q"
else
    echo "Must be: add-reward-program, claim-reward, reward-program, claim-period-reward-distribution"
    exit 1
fi
./provenance.sh $NODE $TYPE "reward" $@