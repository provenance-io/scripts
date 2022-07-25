#!/bin/bash

# Input
NODE=$1

ADDRESS=$(./get_address.sh $NODE)
MSG_TYPE=/cosmos.bank.v1beta1.MsgSend

./provenance.sh $NODE tx msgfees proposal add "adding" "adding-msgsend-fee"  10000000000nhash --msg-type "${MSG_TYPE}" --additional-fee 2000000000nhash \
--home ./node$NODE \
-t \
--chain-id "chain-local" \
--gas auto \
--gas-adjustment 1.5 \
--gas-prices 1905nhash \
--from $ADDRESS \
-y