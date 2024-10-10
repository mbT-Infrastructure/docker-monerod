#!/usr/bin/env bash
set -e -o pipefail

mkdir --parents /media/monerod

exec "$@"
