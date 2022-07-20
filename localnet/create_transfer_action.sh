#!/bin/bash

MIN_ACTIONS="${1:-0}"
MAX_ACTIONS="${2:-0}"
MIN_DELEGATION="${3:-0}"

echo "{\"transfer\":{\"minimum_actions\":\"$MIN_ACTIONS\",\"maximum_actions\":\"$MAX_ACTIONS\",\"minimum_delegation_amount\":{\"denom\":\"nhash\",\"amount\":\"$MIN_DELEGATION\"}}}"