#!/bin/bash

# Tests the following:
# - A program can be created
# - A program can transition to STARTED
# - A program can transition to FINISHED
# - A program can transition to EXPIRED

source ./common_test.sh

# reset time
run set_date

TOMORROW=$(date -u -v+1d '+%Y-%m-%dT%H:%M:%SZ')
ROLLOVER=0
run add_program 0 100000000000000 10000000000 1 1 1 $ROLLOVER $TOMORROW '{"delegate":{"minimum_actions":"0","maximum_actions":"1","minimum_delegation_amount":{"denom":"nhash","amount":"0"},"maximum_delegation_amount":{"denom":"nhash","amount":"1000000000000"},"minimum_active_stake_percentile":"0.10000000000000000","maximum_active_stake_percentile":"1.000000000000000000"}}'
print_program_status

# Start the reward program
wait_for_next_day
run delegate 1 1 1000000nhash
run delegate 2 2 1000000nhash
run delegate 3 3 1000000nhash
run delegate 0 0 1000nhash
run list_delegations 0

# Go into FINISHED state
wait_for_next_day
run claim_reward 0 1

# Go into EXPIRED state
wait_for_next_day

# reset time
run set_date
