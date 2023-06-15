#!/bin/bash

# Input
NODE=$1
ID="${2:-all}"
PIO_SCRIPT="${PIO_SCRIPT:-.}"

$PIO_SCRIPT/provenance.sh $NODE q trigger list $ID \
--home ./node$NODE \
-t \
--chain-id "chain-local"
