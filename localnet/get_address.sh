#!/bin/bash

NODE=$1
./provenance.sh $NODE keys show -a node$NODE --home ./node$NODE -t | sed -n '2 p' | sed 's/.$//'
