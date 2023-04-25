#!/bin/bash

WORK_DIR=$HOME/testnetx
cd $WORK_DIR
id=$(archwayd status | jq -r .NodeInfo.id)
archwayd --home ./node2 start --p2p.seeds $id@localhost:26656
