#!/usr/bin/env bash
set -e -o pipefail

ADDITIONAL_ARGUMENTS=()

if [[ -n "$PROXY_URL" ]]; then
    ADDITIONAL_ARGUMENTS+=("--proxy" "${PROXY_URL#socks5://}")
fi

if [[ "$PRUNE_BLOCKCHAIN" == "true" ]]; then
    ADDITIONAL_ARGUMENTS+=("--prune-blockchain")
fi

/opt/monero/monerod "${ADDITIONAL_ARGUMENTS[@]}" --block-sync-size "$BATCH_SIZE" \
    --confirm-external-bind --data-dir /media/monerod --in-peers 100 --log-file /dev/null \
    --non-interactive --restricted-rpc --rpc-bind-ip 0.0.0.0 --zmq-pub "tcp://0.0.0.0:18083" "$@"
