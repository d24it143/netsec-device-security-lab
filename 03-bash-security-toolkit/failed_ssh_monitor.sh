#!/usr/bin/env bash
# Report source IPs with failed SSH logins at or above a threshold.
# Usage: ./failed_ssh_monitor.sh [threshold] [logfile]
set -euo pipefail

THRESHOLD="${1:-5}"
LOG="${2:-/var/log/auth.log}"

[[ "$THRESHOLD" =~ ^[0-9]+$ ]] || { echo "threshold must be a number" >&2; exit 1; }
[[ -r "$LOG" ]] || { echo "cannot read $LOG (try sudo)" >&2; exit 1; }

awk '/Failed password|Invalid user/ { for (i = 1; i <= NF; i++) if ($i == "from") print $(i + 1) }' "$LOG" \
  | sort | uniq -c | sort -nr \
  | while read -r count ip; do
      if (( count >= THRESHOLD )); then
        echo "[ALERT] $ip had $count failed SSH attempts"
      fi
    done
