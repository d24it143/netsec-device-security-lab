#!/usr/bin/env bash
# Simple file integrity checker using SHA-256 baselines.
# Usage: ./integrity_check.sh init  <dir> [dir...]
#        ./integrity_check.sh check
# Limitation: detects modified and deleted files; does not report NEW files.
set -euo pipefail

BASE="${BASELINE_FILE:-$HOME/.integrity_baseline.sha256}"
usage() { echo "usage: $0 init <dir>... | check" >&2; exit 1; }

[[ $# -ge 1 ]] || usage
mode="$1"; shift

case "$mode" in
  init)
    [[ $# -ge 1 ]] || usage
    find "$@" -type f -print0 2>/dev/null | xargs -0 sha256sum > "$BASE"
    chmod 600 "$BASE"
    echo "Baseline saved to $BASE"
    ;;
  check)
    [[ -f "$BASE" ]] || { echo "no baseline found; run init first" >&2; exit 1; }
    if sha256sum -c --quiet "$BASE" 2>&1; then
      echo "No changes detected"
    else
      echo "[ALERT] changed or missing files listed above" >&2
      exit 2
    fi
    ;;
  *) usage ;;
esac
