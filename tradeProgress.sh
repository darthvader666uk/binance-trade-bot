#!/bin/bash

for i in "$@"; do
    echo $i
    if [ "${i:0:15}" = "--from_coin_id=" ]; then COIN=${i:15}
    fi
done

cmd1="sqlite3 data/crypto_trading.db"
sql0=".mode column"
sql00=".headers on"
sql1="select sh.datetime, p.from_coin_id,
p.to_coin_id, sh.current_coin_price,
sh.other_coin_price, (((current_coin_price / other_coin_price) - 0.001 * 5 * (current_coin_price / other_coin_price)) - sh.target_ratio) as 'ratio_dict'
from scout_history sh
        join pairs p on p.id = sh.pair_id
where p.from_coin_id = '$COIN'
and sh.datetime > DateTime('Now', 'LocalTime', '-5 Second')
order by (((current_coin_price / other_coin_price) - 0.001 * 5 * (current_coin_price / other_coin_price)) - sh.target_ratio) DESC;"
$cmd1 "$sql0" "$sql00"  "$sql1"
