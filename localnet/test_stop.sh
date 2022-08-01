#!/bin/bash

# Tests the following:
# - A program can be created
# - A program can transition to STARTED
# - A program can be stopped
# - A program can transition to FINISHED
# - A program can transition to EXPIRED

source ./common_test.sh

# reset time
run set_date

TOMORROW=$(date -u -v+1d '+%Y-%m-%dT%H:%M:%SZ')
ROLLOVER=1
run add_program 0 100000000000000 10000000000 1 1 1 $ROLLOVER $TOMORROW '{"transfer":{"minimum_actions":"0","maximum_actions":"1","minimum_delegation_amount":{"denom":"nhash","amount":"1000"}}}'
print_program_status

# Start and immediately stop the reward program
wait_for_next_day
run stop_program 0 1
print_program_status

# Go into EXPIRED state
wait_for_next_day

# reset time
run set_date