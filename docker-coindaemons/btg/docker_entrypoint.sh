#!/bin/bash
BITCOIN_DIR=/root/.bgold
BITCOIN_CONF=${BITCOIN_DIR}/bitcoingold.conf

# If config doesn't exist, initialize with sane defaults for running a
# non-mining node.
if [ ! -e "${BITCOIN_CONF}" ]; then
  tee -a >${BITCOIN_CONF} <<EOF

server=1
rpcuser=pooldetective
rpcpassword=pooldetective
rpcclienttimeout=30
rpcallowip=0.0.0.0/0
rpcport=8332
rpcbind=0.0.0.0
printtoconsole=1
disablewallet=1
txindex=0
testnet=0
dbcache=512
prune=1
EOF
fi

if [ $# -eq 0 ]; then
  exec bgoldd -datadir=${BITCOIN_DIR} -conf=${BITCOIN_CONF}
else
  exec "$@"
fi
