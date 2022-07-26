#!/bin/bash

# Tests the following:
# - Multiple programs can run
# - Multiple programs can be in same state
# - Multiple programs can be in different states

source ./common_test.sh

# reset time
run set_date

TOMORROW=$(date -u -v+1d '+%Y-%m-%dT%H:%M:%SZ')
DAY_AFTER_TOMORROW=$(date -u -v+2d '+%Y-%m-%dT%H:%M:%SZ')
ROLLOVER=1
run add_program 0 100000000000000 10000000000 1 1 1 $ROLLOVER $TOMORROW '{"transfer":{"minimum_actions":"0","maximum_actions":"1","minimum_delegation_amount":{"denom":"nhash","amount":"1000"}}}'
run add_program 0 100000000000000 10000000000 1 1 1 $ROLLOVER $DAY_AFTER_TOMORROW '{"transfer":{"minimum_actions":"0","maximum_actions":"1","minimum_delegation_amount":{"denom":"nhash","amount":"1000"}}}'
run add_program 0 100000000000000 10000000000 1 1 1 $ROLLOVER $TOMORROW '{"transfer":{"minimum_actions":"0","maximum_actions":"1","minimum_delegation_amount":{"denom":"nhash","amount":"1000"}}}'

print_program_status

# P1/P3 - 1/1 Period
wait_for_next_day

# P1/P3 - 2/1 Period (Rollover)
wait_for_next_day

# P1/P3 - FINISHED
wait_for_next_day

# P1/P3 - EXPIRED
wait_for_next_day

# P2 - EXPIRED
wait_for_next_day

# reset time
run set_date