#!/usr/bin/env bash
# Back up a directory to a dated tar.gz with a checksum and delete old backups.
# Usage: ./backup_retention.sh <source_dir> <dest_dir> [keep_days]
# Schedule daily at 02:00:  0 2 * * * /path/backup_retention.sh /var/www /backup 7
set -euo pipefail

[[ $# -ge 2 ]] || { echo "usage: $0 <source_dir> <dest_dir> [keep_days]" >&2; exit 1; }
SRC="$1"; DEST="$2"; KEEP="${3:-7}"

[[ -d "$SRC" ]] || { echo "source directory not found: $SRC" >&2; exit 1; }
[[ "$KEEP" =~ ^[0-9]+$ ]] || { echo "keep_days must be a number" >&2; exit 1; }

mkdir -p "$DEST"
ARCHIVE="$DEST/backup_$(basename "$SRC")_$(date +%F_%H%M).tar.gz"

tar -czf "$ARCHIVE" -C "$(dirname "$SRC")" "$(basename "$SRC")"
sha256sum "$ARCHIVE" > "$ARCHIVE.sha256"
find "$DEST" -name 'backup_*.tar.gz*' -mtime +"$KEEP" -delete

echo "Backup created: $ARCHIVE"
