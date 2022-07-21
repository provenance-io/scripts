#!/bin/bash
SLEEP_TIME=30

function separator() {
    echo "==============================================="
}

function run() {
    CMD=$1
    shift
    ./$CMD.sh $@
    separator
}

function print_program_status() {
    run query_reward 0 all
    run query_claims 0 all
}

function wait_for_next_day() {
    TOMORROW=$(date -v+1d +%F)
    run set_date $TOMORROW
    echo "Advancing time to $TOMORROW"
    sleep $SLEEP_TIME
    print_program_status
}