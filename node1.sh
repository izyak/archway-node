#!/bin/bash

cd $HOME
WORK_DIR=$HOME/testnetx
PYSCRIPT_DIR=$HOME/archway-node
VENV_NAME=venv

rm -rf $WORK_DIR

mkdir -p $WORK_DIR
cd $WORK_DIR
mkdir -p node1
mkdir -p node2

# cd node1
archwayd init node1 --chain-id my-chain --home ./node1
archwayd keys add node1-account --home ./node1 >> .n1Key


archwayd init node2 --chain-id my-chain --home ./node2
archwayd keys add node2-account --home ./node2 >> .n2Key

n1Addr=$(grep -oE 'address: \S+' .n1Key | cut -d' ' -f2)
n2Addr=$(grep -oE 'address: \S+' .n2Key | cut -d' ' -f2)

sed -i -e "s|\S*stake\"|\"validatortoken\"|" ./node1/config/genesis.json


# sed -i -e"s|\"accounts\": *\[\]|\"accounts\": [{\"@type\":\"/cosmos.auth.v1beta1.BaseAccount\",\"address\":\"$n1Addr\", \"pub_key\":null,\"account_number\": \"0\", \"sequence\": \"0\"},{\"@type\":\"/cosmos.auth.v1beta1.BaseAccount\",\"address\":\"$n2Addr\",\"pub_key\":null,\"account_number\": \"0\",\"sequence\": \"0\"}]|" ./node1/config/genesis.json
# sed -i -e"s|\"balances\":*\[\]|\"balances\":[{\"address\":\"$n1Addr\",\"coins\":[{\"denom\":\"validatortoken\",\"amount\":\"100000000000000\"}]},{\"address\":\"$n2Addr\",\"coins\":[{\"denom\":\"validatortoken\",\"amount\":\"100000000000000\"}]}]|" ./node1/config/genesis.json

source $HOME/$VENV_NAME/bin/activate
cd $PYSCRIPT_DIR
python3 modify_genesis.py $n1Addr $n2Addr
cd $WORK_DIR

archwayd gentx node1-account 1000000000validatortoken --chain-id my-chain --home ./node1
archwayd collect-gentxs --home ./node1

cd $PYSCRIPT_DIR
python3 modify_toml.py
cd $WORK_DIR
cp node1/config/genesis.json node2/config/genesis.json

archwayd start --home ./node1

