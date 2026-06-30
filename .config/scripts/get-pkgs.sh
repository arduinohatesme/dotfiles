#!/usr/bin/env bash

CACHE="/tmp/available-upgrades"
CACHED=$(cat "$CACHE" || "...")
FLAKE="/home/amcmillan/.config/"

if [ ! -f "$CACHE" ]; then
  echo "..." > "$CACHE"
fi

echo -e "${CACHED} (flakes)"

(
  NOW=$(date +%s)
  LAST_MOD=$(stat -c %Y "$CACHE" 2>/dev/null || echo 0)
  if (( NOW - LAST_MOD > 21600 )) && [ -d "$FLAKE" ]; then
    COUNT=$(nix flake update --flake "path:$FLAKE" --output-lock-file /tmp/dryflake.lock 2>&1 | grep -c "Updated input")
    echo "$COUNT" > "$CACHE"
  fi
) & disown
