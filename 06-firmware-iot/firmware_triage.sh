#!/usr/bin/env bash
# First-pass triage of an EXTRACTED firmware root filesystem.
# Usage: ./firmware_triage.sh <extracted_rootfs_dir>
# Prepare with:  binwalk -e firmware.bin   (rootfs is usually under _firmware.bin.extracted/squashfs-root)
set -uo pipefail

ROOT="${1:?usage: $0 <extracted_rootfs_dir>}"
[[ -d "$ROOT" ]] || { echo "not a directory: $ROOT" >&2; exit 1; }

section() { printf '\n=== %s ===\n' "$1"; }

section "Credential and key files"
find "$ROOT" -type f \( -name passwd -o -name shadow -o -name '*.pem' -o -name '*.key' -o -name '*.crt' \) 2>/dev/null

section "Private keys embedded in files"
grep -rIl "BEGIN .*PRIVATE KEY" "$ROOT" 2>/dev/null

section "Hard-coded secret hints in /etc"
grep -rIniE "(password|passwd|secret|api[_-]?key|token)[[:space:]]*[=:]" "$ROOT/etc" 2>/dev/null | head -50

section "Risky or legacy services referenced"
grep -rIl -E "telnetd|tftpd|ftpd|miniupnpd" "$ROOT/etc" "$ROOT/bin" "$ROOT/sbin" "$ROOT/usr" 2>/dev/null

section "SUID binaries"
find "$ROOT" -type f -perm -4000 2>/dev/null

section "Component versions (map these to CVEs)"
if [[ -f "$ROOT/bin/busybox" ]]; then
  strings -a "$ROOT/bin/busybox" 2>/dev/null | grep -m1 -E "BusyBox v" || true
fi
find "$ROOT" \( -name 'libssl*' -o -name 'libcrypto*' -o -name 'libz*' \) 2>/dev/null

echo
echo "Next: check binary protections with  checksec --file=<binary>  and review web/CGI code."
