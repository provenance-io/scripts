#!/bin/bash
SLEEP_TIME=30

function print_program_status() {
    ./query_reward.sh 0 all
    echo "==============================================="
    ./query_claims.sh 0 all
    echo "==============================================="
}

function wait_for_next_day() {
    echo "==============================================="
    TOMORROW=$(date -v+1d +%F)
    ./set_date.sh $TOMORROW
    echo "Advancing time to $TOMORROW"
    sleep $SLEEP_TIME
    print_program_status
}
# Get the balance of node0
# Create a reward program to start tomorrow from node0
# Check the Reward Program for pending
./balance.sh 0
echo "==============================================="
TOMORROW=$(date -v+1d +%F)
./add_program.sh 0 100000000000000 100000000000000 3 1 1 1 $TOMORROW '{"transfer":{"minimum_actions":"0","maximum_actions":"1","minimum_delegation_amount":{"denom":"nhash","amount":"1000"}}}'
echo "==============================================="
print_program_status
./balance.sh 0
echo "==============================================="

# The purpose of this day is to make a successful transfer and to view how it impacts RewardProgram
# Advance one day
# Sleep for 10 seconds
# Check the Reward Program for started
# Check the Reward Claim
# Make a transfer from node1 to node2
# Get the balance of node1
# Get the balance of node2
# Check the Reward Claim
# Attempt to make claim for period 1
# Check the Reward Program
wait_for_next_day
./transfer.sh 1 2 1000nhash
echo "==============================================="
./balance.sh 0
echo "==============================================="
./balance.sh 1
echo "==============================================="
./claim_reward.sh 1 1
echo "==============================================="
print_program_status

# The purpose of this day is to make a successful claim and another successful transfer.
# It also helps view ensure a new claim object is created and to view the before/after state of RewardProgram
# A failed transfer from node2 will also be made that does not meet the eligiblity criteria
# Advance 1 day
# Sleep for 10 seconds
# Check the Reward Program
# Check the Reward Claim
# Make a claim from node1 for period 1
# Get the balance of node1
# Make a transfer from node1 to node2
# Make a successful transfer from node2 to node3
# Get the balance of node1
# Get the balance of node2
wait_for_next_day
./claim_reward.sh 1 1
echo "==============================================="
./balance.sh 1
echo "==============================================="
./transfer.sh 1 2 1000nhash
echo "==============================================="
./transfer.sh 2 3 1000nhash
echo "==============================================="
./balance.sh 1
echo "==============================================="
./balance.sh 2
echo "==============================================="
./balance.sh 3
echo "==============================================="
print_program_status

# The purpose of this day is to ensure we have funds for a rollover
# It also ensures that funds can be split
# Advance 1 day
# Sleep for 10 seconds
# Check the Reward Program
# Check the Reward Claim
wait_for_next_day

# The purpose of this is to test rollover and to have something unclaimed
# Advance 1 day (Rollover)
# Sleep for 10 seconds
# Check the Reward Program
# Check the Reward Claim
# Make a transfer from node1 to node2
# Get the balance of node1
# Get the balance of node2
wait_for_next_day
./transfer.sh 1 2 1000nhash
echo "==============================================="
./balance.sh 1
echo "==============================================="
./balance.sh 2
echo "==============================================="
./claim_reward.sh 1 1
echo "==============================================="
./claim_reward.sh 2 1
echo "==============================================="
./balance.sh 1
echo "==============================================="
./balance.sh 2
echo "==============================================="
print_program_status

# The purpose of this is to test we can go into finished state
# It also tests that we can still claim in the finished state
# Advance 1 day (FINISHED STATE)
# Sleep for 10 seconds
# Check the Reward Program
# Check the Reward Claim
wait_for_next_day

# The purpose of this is to test that we go into expired state
# It also tests that we can't claim anything
# It also tests refunding
# Advance 1 day (EXPIRED STATE)
# Sleep for 10 seconds
# Check the Reward Program
# Check the Reward Claim
# Try to make an expired claim from node1 from period 4
# Check the balance of node1
# Check the balance of node0
wait_for_next_day
./claim_reward.sh 1 1
echo "==============================================="
./balance.sh 1
echo "==============================================="
./balance.sh 0
echo "==============================================="
print_program_status

# reset time
./set_date.sh