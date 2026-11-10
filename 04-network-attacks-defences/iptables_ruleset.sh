#!/usr/bin/env bash
# Default-deny host firewall for a LAB VM. Run as root.
# WARNING: you can lock yourself out of SSH. Keep VM console access and test first.
# Usage: sudo ADMIN_NET=192.168.56.0/24 ./iptables_ruleset.sh
set -euo pipefail

[[ $EUID -eq 0 ]] || { echo "run as root" >&2; exit 1; }
ADMIN_NET="${ADMIN_NET:-192.168.56.0/24}"

iptables -F
iptables -X
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -p tcp --dport 22 -s "$ADMIN_NET" -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT
iptables -A INPUT -p icmp --icmp-type echo-request -m limit --limit 5/second -j ACCEPT
iptables -A INPUT -m limit --limit 5/min -j LOG --log-prefix "iptables-drop: "

iptables -L -n -v --line-numbers
echo "Rules are not persistent (lost on reboot) by design for the lab."
