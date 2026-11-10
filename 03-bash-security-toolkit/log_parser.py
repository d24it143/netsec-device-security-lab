#!/usr/bin/env python3
"""Count failed SSH logins per source IP from an auth log.

Usage: python3 log_parser.py /var/log/auth.log [--top 10]
"""
import argparse
import re
import sys
from collections import Counter

PATTERN = re.compile(r"(?:Failed password|Invalid user).* from (\S+)")


def count_failures(path):
    counts = Counter()
    with open(path, "r", errors="replace") as handle:
        for line in handle:
            match = PATTERN.search(line)
            if match:
                counts[match.group(1)] += 1
    return counts


def main():
    parser = argparse.ArgumentParser(description="Count failed SSH logins per IP")
    parser.add_argument("logfile")
    parser.add_argument("--top", type=int, default=10)
    args = parser.parse_args()

    try:
        counts = count_failures(args.logfile)
    except OSError as exc:
        print(f"error: {exc}", file=sys.stderr)
        return 1

    if not counts:
        print("No failed logins found")
        return 0
    for ip, total in counts.most_common(args.top):
        print(f"{total:6d}  {ip}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
