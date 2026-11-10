# 02 - Linux fundamentals for security

## Goal
Be fluent with the Linux command line, permissions, users, processes, services, logs and network inspection.

## Checklist
- [ ] File system layout (`/etc`, `/var/log`, `/proc`, `/dev`, `/tmp`)
- [x] Users, groups, `/etc/passwd` vs `/etc/shadow`, sudo
- [x] Permissions, umask, SUID/SGID/sticky-bit inspection
- [x] Processes, systemd, cron
- [x] Log analysis with grep/awk and journalctl
- [x] OverTheWire Bandit levels 0 to 10
- [x] Network inspection: sockets, interfaces, routes and neighbours

See [cheatsheet.md](cheatsheet.md) and [bandit-notes.md](bandit-notes.md).

## Lab notes

| Task | Command / technique | Verified result |
|---|---|---|
| Users and groups | `useradd`, `usermod`, `id`, `getent` | Created user `alice` (UID 1001) and added her to supplementary group `devs` (GID 1002). |
| Account files | `getent passwd`, `ls -l /etc/passwd /etc/shadow` | `/etc/passwd` was world-readable; `/etc/shadow` was restricted to root and shadow group. |
| File permissions | `chmod`, `chown`, `stat` | Tested mode 640 and ownership changes. Observed that only the file owner can change its permissions without elevated privileges. |
| Umask | `umask`, `touch`, `mkdir` | Default umask 002 produced file mode 664 and directory mode 775. Umask 077 produced 600 and 700. |
| SUID files | `find / -perm -4000 -type f 2>/dev/null` | Identified SUID executables, including `/usr/bin/passwd`. |
| SGID files | `find / -perm -2000 -type f 2>/dev/null` | Identified SGID executables on the Kali VM. |
| Sticky bit | `ls -ld /tmp` | `/tmp` had the sticky bit set (`drwxrwxrwt`). |
| Linux capabilities | `getcap -r / 2>/dev/null` | Observed capabilities on tools including `nmap`, `dumpcap` and `fping`. |
| Processes | `ps auxf`, `top`, `pgrep` | Inspected process hierarchy and resource usage; created and terminated a temporary `sleep` process. |
| Services and scheduled jobs | `systemctl`, `crontab -l`, `systemctl list-timers` | Inspected running services, SSH service status, cron entries and systemd timers. |
| Authentication logs | `rsyslog`, `grep`, `awk`, `journalctl` | Installed and enabled rsyslog, generated three failed SSH password attempts for an invalid local user, and identified `::1` in the log search. |
| SSH hardening | `systemctl disable --now ssh` | Verified SSH became inactive and disabled. |
| Listening sockets | `ss -tulpn` | Observed xrdp listening on TCP port 3389 and NetworkManager using UDP port 546. |
| Network interfaces | `ip a` | Identified NAT interface `eth0` (10.0.2.15) and host-only interface `eth1` (192.168.56.2). |
| Routing | `ip r` | Default route used gateway 10.0.2.2 through `eth0`; host-only subnet used `eth1`. |
| Neighbour discovery | `ip neigh` | Observed IPv4 and IPv6 neighbours and cached MAC mappings in STALE state. |

## What I learned

- Linux users have UIDs and groups have GIDs. A user can belong to supplementary groups.
- `/etc/passwd` stores account information; `/etc/shadow` stores protected password hashes.
- File permissions are based on owner, group and others. Changing file ownership affects who can change its permissions.
- Umask removes permissions from the default creation modes.
- SUID, SGID and sticky bits affect privilege and access behaviour.
- Linux capabilities provide granular privileges to executables.
- `ps`, `top` and `systemctl` help inspect processes and services.
- Authentication events can be investigated using `/var/log/auth.log` and `journalctl`.
- `ss`, `ip a`, `ip r` and `ip neigh` help inspect sockets and network configuration.
- A service listening on a port is not automatically exposed to the public internet; network configuration and firewall rules also matter.

## Security observations

- Do not share or commit `/etc/shadow` contents, password hashes or private keys.
- Keep unused services disabled where appropriate.
- SSH was disabled after the authentication-log exercise.
- Investigate whether xrdp on TCP port 3389 is required and restrict its access appropriately.
