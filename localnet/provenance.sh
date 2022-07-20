#!/bin/bash

NODE=$1
shift
CMD=$@

echo "provenanced $CMD"

docker exec -it node$NODE provenanced $CMD