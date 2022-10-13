# DEFAULTS
TOMORROW=$(date -u -v+1d '+%Y-%m-%dT%H:%M:%SZ')
STRING=$(echo "$RANDOM" | md5sum | head -c 20)
DELEGATE=$(./create_delegate_action.sh)

# Input
NODE=$1
ADDRESS=$(./get_address.sh $NODE)
TOTAL_POOL="${2:-580}"
MAX_REWARD="${3:-10}"
PERIODS="${4:-364}"
PERIOD_LENGTH="${5:-7}"
EXPIRE="${6:-14}"
MAX_ROLLOVER="${7:-14}"
START="${8:-$TOMORROW}"
ACTIONS="${9:-$DELEGATE}"

./reward_program.sh $NODE add-reward-program "$STRING" "$STRING" \
--home ./node$NODE \
-t \
--total-reward-pool "${TOTAL_POOL}nhash" \
--max-reward-by-address "${MAX_REWARD}nhash" \
--start-time "$START" \
--claim-periods "$PERIODS" \
--claim-period-days "$PERIOD_LENGTH" \
--expire-days "$EXPIRE" \
--max-rollover-periods "$MAX_ROLLOVER" \
--qualifying-actions "{\"qualifying_actions\":[$ACTIONS]}" \
--chain-id "chain-local" \
--gas auto \
--gas-adjustment 1.5 \
--gas-prices 1905nhash \
-y \
--from "$ADDRESS" \