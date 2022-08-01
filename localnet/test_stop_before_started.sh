#!/bin/bash

# Tests the following:
# - A program can be created
# - A program can be destroyed

source ./common_test.sh

# reset time
run set_date

TOMORROW=$(date -u -v+1d '+%Y-%m-%dT%H:%M:%SZ')
ROLLOVER=1
run add_program 0 100000000000000 10000000000 1 1 1 $ROLLOVER $TOMORROW '{"transfer":{"minimum_actions":"0","maximum_actions":"1","minimum_delegation_amount":{"denom":"nhash","amount":"1000"}}}'
print_program_status

# Stop the reward program
run stop_program 0 1
print_program_status

# reset time
run set_date