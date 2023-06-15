#!/bin/bash

# Input
NODE=$1
ID=$2
PIO_SCRIPT="${PIO_SCRIPT:-.}"

ADDRESS=$($PIO_SCRIPT/get_address.sh $NODE)

$PIO_SCRIPT/provenance.sh $NODE tx trigger destroy-trigger $ID \
--home ./node$NODE \
-t \
--chain-id "chain-local" \
--gas auto \
--gas-adjustment 1.5 \
--gas-prices 1905nhash \
--from $ADDRESS \
-y