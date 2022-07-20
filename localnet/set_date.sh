#!/bin/bash
RESET="reset"

DATE=${1:-$RESET}

if [[ "$DATE" == "$RESET" ]]; then
    sudo sntp -S time.apple.com
else
    sudo date -f "%F" $DATE
fi
