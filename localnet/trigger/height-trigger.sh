#!/bin/bash

# Input
NODE=$1
HEIGHT=$2
ACTION="${3:-bank_send.json}"
PIO_SCRIPT="${PIO_SCRIPT:-.}"

ADDRESS=$($PIO_SCRIPT/get_address.sh $NODE)

$PIO_SCRIPT/provenance.sh $NODE tx trigger create-height-trigger $HEIGHT $ACTION \
--home ./node$NODE \
-t \
--chain-id "chain-local" \
--gas auto \
--gas-adjustment 1.5 \
--gas-prices 1905nhash \
--from $ADDRESS \
-y