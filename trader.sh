#!/bin/bash

echo "Running Trader Local ..."

pip3 install -r requirements.txt

# python crypto_trading.py

python3 -m binance_trade_bot
