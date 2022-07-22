#!/bin/bash

# Tests the following:
# - A program receives the appropriate balance
# - A claim can't be done on the same period the share was granted
# - A claim can be done in a normal period
# - A share can be granted in a rollover period
# - A claim can be done in a rollover period
# - Claims can expire and can't be claimed in EXPIRE program state
# - Refunding remaining program balance
# - Refunding unclaimed reward claims
source ./common_test.sh

# reset time
run set_date

# Create a Reward Program that starts tomorrow
TOMORROW=$(date -v+1d +%F)
run add_program 0 100000000000000 100000000000000 3 1 1 1 $TOMORROW '{"transfer":{"minimum_actions":"0","maximum_actions":"1","minimum_delegation_amount":{"denom":"nhash","amount":"1000"}}}'
print_program_status
run balance 0

# Period 1/3
# Transfer, check balances, and failed claim attempt
wait_for_next_day
run transfer 1 2 1000nhash
run balance 0
run balance 1
run claim_reward 1 1
print_program_status

# Period 2/3
# Successful claim, transfers, and view balances
wait_for_next_day
run claim_reward 1 1
run balance 1
run transfer 1 2 1000nhash
run transfer 2 3 1000nhash
run balance 1
run balance 2
run balance 3
print_program_status

# Period 3/3
# Nothing
wait_for_next_day

# Period 4/3 (Rollover)
# Transfer, claim rewards, and check balances
wait_for_next_day
run transfer 1 2 1000nhash
run balance 1
run balance 2
run claim_reward 1 1
run claim_reward 2 1
run balance 1
run balance 2
print_program_status

# FINISHED
# Do nothing, claim for Node1 goes unclaimed
wait_for_next_day

# EXPIRED
# Failed claim attempt, and check balances
# Refunding should happen for claim and remaining balance
wait_for_next_day
run claim_reward 1 1
run balance 1
run balance 0
print_program_status

# reset time
run set_date