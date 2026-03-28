#!/bin/bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PROFILE="${1:-full}"

exec "$ROOT_DIR/scripts/archdev" init && "$ROOT_DIR/scripts/archdev" apply "$PROFILE"
