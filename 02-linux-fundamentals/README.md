# 02 - Linux fundamentals for security

## Goal
Be fluent with the Linux command line, permissions, users, processes and logs.

## Checklist (tick when done and run on my VM)
- [ ] File system layout (`/etc`, `/var/log`, `/proc`, `/dev`, `/tmp`)
- [ ] Users, groups, `/etc/passwd` vs `/etc/shadow`, sudo
- [ ] Permissions, umask, SUID/SGID/sticky
- [ ] Processes, systemd, cron
- [ ] Log analysis with grep/awk/sed
- [ ] OverTheWire Bandit levels 0 to 10

See [cheatsheet.md](cheatsheet.md).

## Lab notes
| Task | Command | Result |
|---|---|---|
| Find SUID files | `find / -perm -4000 -type f 2>/dev/null` | |
| Listening ports + process | `ss -tulpn` | |
| Service logs | `journalctl -u ssh -n 50` | |
| Failed SSH logins | see `../03-bash-security-toolkit/failed_ssh_monitor.sh` | |

## What I learned
- 
