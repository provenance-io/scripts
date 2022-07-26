#!/bin/bash

# Tests the following:
# - Multiple programs can run
# - Multiple programs can be in same state
# - Multiple programs can be in different states

source ./common_test.sh

# reset time
run set_date

TOMORROW=$(date -u -v+1d '+%Y-%m-%dT%H:%M:%SZ')
ROLLOVER=0
run add_program 0 100000000000000 10000000000 1 1 1 $ROLLOVER $TOMORROW '{"transfer":{"minimum_actions":"0","maximum_actions":"1","minimum_delegation_amount":{"denom":"nhash","amount":"1000"}}}'
run add_program 0 100000000000000 10000000000 1 1 1 $ROLLOVER $TOMORROW '{"transfer":{"minimum_actions":"0","maximum_actions":"1","minimum_delegation_amount":{"denom":"nhash","amount":"1000"}}}'

print_program_status

# 1/1 Period
wait_for_next_day
run transfer 1 2 1000nhash

# FINISHED
wait_for_next_day
run claim_reward 1 all

# EXPIRED
wait_for_next_day

# reset time
run set_date