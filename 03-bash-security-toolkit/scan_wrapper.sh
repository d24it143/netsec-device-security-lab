#!/usr/bin/env bash
# Nmap wrapper: scan an AUTHORISED target and save a dated report.
# Usage: ./scan_wrapper.sh <target-ip-or-cidr>
set -euo pipefail

[[ $# -eq 1 ]] || { echo "usage: $0 <target-ip-or-cidr>" >&2; exit 1; }
command -v nmap >/dev/null || { echo "nmap is not installed" >&2; exit 1; }

TARGET="$1"
read -r -p "Do you own or have written permission to scan $TARGET? (yes/no) " ans
[[ "$ans" == "yes" ]] || { echo "Aborting." >&2; exit 1; }

OUTDIR="reports"
mkdir -p "$OUTDIR"
SAFE="${TARGET//\//_}"
OUT="$OUTDIR/scan_${SAFE}_$(date +%F_%H%M)"

nmap -sV -T3 --open -oA "$OUT" "$TARGET"

echo "--- Open ports summary ---"
grep -E "^[0-9]+/(tcp|udp) +open" "${OUT}.nmap" | awk '{print $1, $3}' | sort | uniq -c | sort -nr || true
echo "Reports saved: ${OUT}.nmap / .xml / .gnmap"
