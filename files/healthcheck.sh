#!/usr/bin/env bash
set -e -o pipefail

curl --fail http://localhost:18081/get_height || exit 1
