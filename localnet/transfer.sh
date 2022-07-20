#!/bin/bash

# Input
FROM_NODE=$1
TO_NODE=$2
AMOUNT=$3

FROM_ADDRESS=$(./get_address.sh $FROM_NODE)
TO_ADDRESS=$(./get_address.sh $TO_NODE)

./provenance.sh $FROM_NODE tx bank send $FROM_ADDRESS $TO_ADDRESS $AMOUNT \
--home ./node$FROM_NODE \
-t \
--chain-id "chain-local" \
--gas auto \
--gas-adjustment 1.5 \
--gas-prices 1905nhash \
--from $FROM_ADDRESS \