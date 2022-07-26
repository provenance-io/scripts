#!/bin/bash

# Tests the following:
# - A program can be made
# - A program can transition between all states
# - A claim can be created during a normal period
# - A claim can be created during a rollover period
# - A transfer can be claimed on FINISHED
# - A transfer cannot be claimed on EXPIRED
# - Invalid claiming will not work
# - Refunding a claim and balance both work together

source ./common_test.sh

# reset time
run set_date

# Create a Reward Program that starts tomorrow
TOMORROW=$(date -u -v+1d '+%Y-%m-%dT%H:%M:%SZ')
ROLLOVER=1
run add_program 0 100000000000000 10000000000 1 1 1 $ROLLOVER $TOMORROW '{"transfer":{"minimum_actions":"0","maximum_actions":"1","minimum_delegation_amount":{"denom":"nhash","amount":"1000"}}}'
run balance 0
print_program_status

# Period 1/1
# Transfer
wait_for_next_day
run transfer 1 2 1000nhash

# Period 2/1
# Transfer
wait_for_next_day
run transfer 2 3 1000nhash

# FINISHED
# Successful claim
wait_for_next_day
run claim_reward 1 1
run balance 1

# EXPIRED
# Failed claim and check balances
wait_for_next_day
run claim_reward 2 1
run balance 2
run balance 0

# reset time
./set_date.sh