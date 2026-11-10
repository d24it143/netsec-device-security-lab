# 03 - Bash and Python security toolkit

Small, readable automation tools for monitoring and administration. Each script validates input, fails safely (`set -euo pipefail`) and does one job.

| Script | Purpose | Example |
|---|---|---|
| `failed_ssh_monitor.sh` | Alert on IPs with repeated failed SSH logins | `sudo ./failed_ssh_monitor.sh 5` |
| `scan_wrapper.sh` | Nmap scan of an authorised target with a dated report | `./scan_wrapper.sh 192.168.56.101` |
| `integrity_check.sh` | SHA-256 baseline and change detection | `./integrity_check.sh init /etc` then `check` |
| `port_audit.sh` | Flag listening ports not on an allow-list | `ALLOWED_PORTS="22 443" ./port_audit.sh` |
| `backup_retention.sh` | Dated backup with checksum and retention | `./backup_retention.sh ~/data ~/backup 7` |
| `log_parser.py` | Count failed logins per IP in Python | `python3 log_parser.py /var/log/auth.log` |

## Test notes (fill in with real output)
- Environment: Kali Linux, Bash `____`, Python `____`
- `failed_ssh_monitor.sh`: tested by failing logins on my own VM. Output:
- `port_audit.sh`: tested by starting `python3 -m http.server 8000`. Output:

## Known limitations
- `integrity_check.sh` does not detect newly added files.
- `failed_ssh_monitor.sh` only reports; blocking should be done by a tool such as fail2ban or an nftables set, with an allow-list so admins do not lock themselves out.

## Lint
```bash
shellcheck *.sh
```
