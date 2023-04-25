#!/bin/bash

WALLET=node2-account
CONTRACT_WASM=artifacts/archway_starter.wasm 
# ENDPOINT=https://rpc.constantine-2.archway.tech:443 
ENDPOINT=http://localhost:26657
CHAIN_ID=my-chain

RES=$(archwayd tx wasm store $CONTRACT_WASM --from $WALLET --node $ENDPOINT --chain-id $CHAIN_ID --gas-prices 0.25validatortoken --gas auto --gas-adjustment 1.3 -y --output json -b block)

echo "Result: "
echo $RES

CODE_ID=$(echo $RES | jq -r '.logs[0].events[] | select(.type=="store_code") | .attributes[] | select(.key=="code_id") | .value')

echo "Code ID: "
echo $CODE_ID

# The two binaries should be identical
# archwayd query wasm code $CODE_ID --node https://rpc.constantine-2.archway.tech:443 download.wasm
# diff artifacts/cw_nameservice.wasm download.wasm

# Cosntructor params // stringified json
INIT='{"count":0}'
archwayd tx wasm instantiate $CODE_ID "$INIT" --from $WALLET --label "name service" --node $ENDPOINT --chain-id $CHAIN_ID --gas-prices 0.25validatortoken --gas auto --gas-adjustment 1.3 -y --no-admin

archwayd query wasm list-contract-by-code $CODE_ID --node $ENDPOINT --output json

echo "+++++"
CONTRACT=$(archwayd query wasm list-contract-by-code $CODE_ID --node $ENDPOINT --output json | jq -r '.contracts[-1]')
echo $CONTRACT

archwayd query wasm contract $CONTRACT --node $ENDPOINT

# query entire contract state
archwayd query wasm contract-state all $CONTRACT --node $ENDPOINT 

# query state
# utf8ToBytes("state") = 7374617465
archwayd query wasm contract-state raw $CONTRACT 7374617465  --node $ENDPOINT