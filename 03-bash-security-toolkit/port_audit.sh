#!/usr/bin/env bash
# Compare listening TCP/UDP ports on this host against an allow-list.
# Usage: ALLOWED_PORTS="22 443" ./port_audit.sh
set -euo pipefail

ALLOWED="${ALLOWED_PORTS:-22 80 443}"
status=0

while read -r port; do
  [[ -n "$port" ]] || continue
  if [[ " $ALLOWED " != *" $port "* ]]; then
    echo "[WARN] unexpected listening port: $port"
    status=1
  fi
done < <(ss -H -tuln | awk '{n = split($5, a, ":"); print a[n]}' | sort -un)

if [[ $status -eq 0 ]]; then
  echo "All listening ports are in the allow-list: $ALLOWED"
fi
exit $status
