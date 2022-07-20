#!/bin/bash

MIN_ACTIONS="${1:-0}"
MAX_ACTIONS="${2:-0}"
MIN_DELEGATION="${3:-0}"
MAX_DELEGATION="${4:-0}"
MIN_PERCENTILE="${5:-0.000000000000000000}"
MAX_PERCENTILE="${6:-1.000000000000000000}"

echo "{\"delegate\":{\"minimum_actions\":\"$MIN_ACTIONS\",\"maximum_actions\":\"$MAX_ACTIONS\",\"minimum_delegation_amount\":{\"denom\":\"nhash\",\"amount\":\"$MIN_DELEGATION\"},\"maximum_delegation_amount\":{\"denom\":\"nhash\",\"amount\":\"$MAX_DELEGATION\"},\"minimum_active_stake_percentile\":\"$MIN_PERCENTILE\",\"maximum_active_stake_percentile\":\"$MAX_PERCENTILE\"}}"