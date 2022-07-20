#!/bin/bash

NODE=$1
./provenance.sh $NODE keys list --home ./node$NODE -t | sed -n '4 p' | awk '{print substr($2, 0, length($2)-1)}' -