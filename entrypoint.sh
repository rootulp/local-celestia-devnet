#!/usr/bin/env bash

# Stop script execution if an error is encountered
set -o errexit
# Stop script execution if an undefined variable is used
set -o nounset

echo "starting script..."
FOO=$(which celestia-appd)
echo "which celestia-appd: ${FOO}"
echo "PATH: ${PATH}"
echo "ls -al /bin/celestia-appd: $(ls -al /bin/celestia-appd)"
echo "file /bin/celestia-appd: $(file /bin/celestia-appd)"
echo "ldd /bin/celestia-appd: $(ldd /bin/celestia-appd)"
echo "uname -m: $(uname -m)"
echo "arch: $(arch)"
echo "lscpu: $(lscpu)"

echo "celestia-appd --help: $(celestia-appd --help)"

CELESTIA_APP_HOME="/home/celestia/.celestia-app"
CELESTIA_APP_VERSION=$(celestia-appd version 2>&1)

echo "celestia-app home: ${CELESTIA_APP_HOME}"
echo "celestia-app version: ${CELESTIA_APP_VERSION}"
echo ""

CELESTIA_NODE_HOME="/home/celestia/bridge/"
CELESTIA_NODE_VERSION=$(celestia version)
echo "celestia-node home: ${CELESTIA_NODE_HOME}"
echo "celestia-node version: ${CELESTIA_NODE_VERSION}"
echo ""

# CHAIN_ID="private"
# KEY_NAME="validator"
# KEYRING_BACKEND="test"
# COINS="1000000000000000utia"
# DELEGATION_AMOUNT="5000000000utia"

# celestia-appd init $CHAIN_ID --chain-id $CHAIN_ID
# celestia-appd keys add validator --keyring-backend="test"
# # this won't work because some proto types are declared twice and the logs output to stdout (dependency hell involving iavl)
# celestia-appd add-genesis-account $(celestia-appd keys show validator -a --keyring-backend="test") $coins
# celestia-appd gentx validator 5000000000utia \
#   --keyring-backend="test" \
#   --chain-id $CHAIN_ID

# celestia-appd collect-gentxs

# # Set proper defaults and change ports
# # If you encounter: `sed: -I or -i may not be used with stdin` on MacOS you can mitigate by installing gnu-sed
# # https://gist.github.com/andre3k1/e3a1a7133fded5de5a9ee99c87c6fa0d?permalink_comment_id=3082272#gistcomment-3082272
# sed -i'.bak' 's#"tcp://127.0.0.1:26657"#"tcp://0.0.0.0:26657"#g' ~/.celestia-app/config/config.toml
# sed -i'.bak' 's/timeout_commit = "25s"/timeout_commit = "1s"/g' ~/.celestia-app/config/config.toml
# sed -i'.bak' 's/timeout_propose = "3s"/timeout_propose = "1s"/g' ~/.celestia-app/config/config.toml
# sed -i'.bak' 's/index_all_keys = false/index_all_keys = true/g' ~/.celestia-app/config/config.toml
# sed -i'.bak' 's/mode = "full"/mode = "validator"/g' ~/.celestia-app/config/config.toml

# # Register the validator EVM address
# {
#   # wait for block 1
#   sleep 20

#   # private key: da6ed55cb2894ac2c9c10209c09de8e8b9d109b910338d5bf3d747a7e1fc9eb9
#   celestia-appd tx qgb register \
#     "$(celestia-appd keys show validator --home "${CELESTIA_APP_HOME}" --bech val -a)" \
#     0x966e6f22781EF6a6A82BBB4DB3df8E225DfD9488 \
#     --from validator \
#     --home "${CELESTIA_APP_HOME}" \
#     --fees 30000utia -b block \
#     -y
# } &

# mkdir -p $CELESTIA_NODE_HOME/keys
# cp -r $CELESTIA_APP_HOME/keyring-test/ $CELESTIA_NODE_HOME/keys/keyring-test/

# # Start the celestia-app
# celestia-appd start &

# # Try to get the genesis hash. Usually first request returns an empty string (port is not open, curl fails), later attempts
# # returns "null" if block was not yet produced.
# GENESIS=
# CNT=0
# MAX=30
# while [ "${#GENESIS}" -le 4 -a $CNT -ne $MAX ]; do
# 	GENESIS=$(curl -s http://127.0.0.1:26657/block?height=1 | jq '.result.block_id.hash' | tr -d '"')
# 	((CNT++))
# 	sleep 1
# done

# export CELESTIA_CUSTOM=test:$GENESIS
# echo $CELESTIA_CUSTOM

# celestia bridge init --node.store /home/celestia/bridge
# export CELESTIA_NODE_AUTH_TOKEN=$(celestia bridge auth admin --node.store ${CELESTIA_NODE_HOME})
# echo "WARNING: Keep this auth token secret **DO NOT** log this auth token outside of development. CELESTIA_NODE_AUTH_TOKEN=$CELESTIA_NODE_AUTH_TOKEN"
# celestia bridge start \
#   --node.store $CELESTIA_NODE_HOME --gateway \
#   --core.ip 127.0.0.1 \
#   --keyring.accname validator \
#   --gateway.deprecated-endpoints
