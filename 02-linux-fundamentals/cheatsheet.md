# Linux security cheat sheet

## Permissions
- r=4, w=2, x=1. `chmod 754 f` = rwx r-x r--. `umask 022` -> files 644, dirs 755.
- SUID (4000) runs as file owner; SGID (2000); sticky (1000) on `/tmp`.
- `find / -perm -4000 -type f 2>/dev/null` lists SUID binaries.

## Users and auth
```bash
id; whoami; last | head; lastb | head
awk -F: '$3==0 {print $1}' /etc/passwd      # UID 0 accounts
sudo -l                                      # my sudo rights
```

## Processes and services
```bash
ps auxf; top; pgrep -a ssh
systemctl status ssh; journalctl -u ssh -n 50; journalctl -p err --since today
```

## Network
```bash
ip a; ip r; ip neigh
ss -tulpn                  # listening sockets + process
dig example.com +short; curl -I https://example.com
```

## Logs
- Debian/Ubuntu/Kali: `/var/log/auth.log`; RHEL: `/var/log/secure`
```bash
grep "Failed password" /var/log/auth.log | awk '{for(i=1;i<=NF;i++) if($i=="from") print $(i+1)}' | sort | uniq -c | sort -nr | head
```

## Hardening basics
- Patch, remove unused services, SSH keys only, default-deny firewall, least-privilege sudo, auditd, remote logging.
