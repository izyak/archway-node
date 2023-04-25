# Run Archway Node with 2 validators


## Install prequisities

- **tomli and tomli_w**

    Install them in a python venv.
```sh
source ~/<-venv->/bin/activate
pip3 install -r requirements.txt
```
- **archwayd**
```sh
git clone https://github.com/archway-network/archway
cd archway
git checkout main
make install
```
- **jq**
```sh
sudo apt install jq
```


## Run 
- On line number 4 of `node1.sh`, replace the path where you cloned `archway-node`; ($HOME/archway-node by default)
- On line number 5 of `node1.sh`, replace the name of venv. (venv by default)
- All the generated files will be in `~/testnetx` directory.
### Run Node 1
```sh
./node1.sh
```

### On another terminal
```sh
./node2.sh
```
This runs 2 validator nodes for the archway local network.

## Deploy WASM Contracts
Use deploy.sh script to deploy wasm contracts on localnet. The current file has code to deploy increment contract on localnet. The wasm file location is specified in `CONTRACT_WASM` and wallet to deploy it on the variable `WALLET`. The variable `INIT` is the arguments for constructor.
```sh
./deploy.sh
```

## Clear
To clear all the generated files.
```sh
rm -rf ~/testnetx
```