#!/bin/bash
set -euo pipefail

CONFIG="/boot/limine/limine.conf"
TEMP=$(mktemp /tmp/limine_snapshot_entries.XXXXXX)
MAX_SNAPSHOTS=3

cleanup() { rm -f "$TEMP"; }
trap cleanup EXIT INT TERM

[[ -f "$CONFIG" ]] || exit 0
command -v snapper >/dev/null 2>&1 || exit 0

extract_entry() {
  local pattern="$1"
  awk -v pat="$pattern" '$0 ~ pat {capture=1} capture {print} capture && NF==0 {exit}' "$CONFIG"
}

BASE_LINUX=$(extract_entry '^/Arch Linux \(linux\)$')
BASE_LTS=$(extract_entry '^/Arch Linux \(linux-lts\)$')
[[ -n "$BASE_LINUX" ]] || exit 0

SNAPSHOTS=$(snapper list | awk 'NR>2 && $1 ~ /^[0-9]+$/ && $1 != "0" {print $1}' | sort -nr | head -n "$MAX_SNAPSHOTS" || true)
[[ -n "$SNAPSHOTS" ]] || exit 0

: > "$TEMP"
for SNAP in $SNAPSHOTS; do
  SNAP_PATH="@/.snapshots/$SNAP/snapshot"
  NEW_LINUX=$(printf '%s\n' "$BASE_LINUX" | sed "s#/Arch Linux (linux)#/Arch Linux Snapshot $SNAP (linux)#g" | sed -E "s#rootflags=subvol=[^ ]+#rootflags=subvol=$SNAP_PATH#g")
  printf '%s\n\n' "$NEW_LINUX" >> "$TEMP"
  if [[ -n "$BASE_LTS" ]]; then
    NEW_LTS=$(printf '%s\n' "$BASE_LTS" | sed "s#/Arch Linux (linux-lts)#/Arch Linux Snapshot $SNAP (linux-lts)#g" | sed -E "s#rootflags=subvol=[^ ]+#rootflags=subvol=$SNAP_PATH#g")
    printf '%s\n\n' "$NEW_LTS" >> "$TEMP"
  fi
done

python - "$CONFIG" "$TEMP" <<'PY'
from pathlib import Path
import re, sys
config = Path(sys.argv[1])
temp = Path(sys.argv[2])
content = config.read_text()
entries = temp.read_text().rstrip() + "\n"
content = re.sub(r'(?ms)^/Arch Linux Snapshot .*?(?:\n\s*\n|\Z)', '', content)
content = content.rstrip() + "\n\n" + entries
config.write_text(content)
PY
