# 04 - Network attacks and defences (isolated lab)

**Lab:** Kali Linux + a vulnerable target VM (for example Metasploitable2) on a VirtualBox **host-only** network. Nothing here touches real networks.

| # | Experiment | Attack/observation | Detection | Defence | Evidence |
|---|---|---|---|---|---|
| 1 | Nmap scans | `-sn`, `-sS`, `-sV`, `-O`, `-p-`, `--script vuln` | - | Close ports, firewall | screenshots / notes |
| 2 | ARP spoofing | | Wireshark: duplicate IP, MAC change | DAI, static ARP, encryption | |
| 3 | SYN flood (`hping3`) | | many SYN, few ACK | SYN cookies, rate limit | |
| 4 | Firewall | | | `iptables_ruleset.sh` | |
| 5 | SSH hardening | | | `sshd_hardening.md` | |

## Findings report template
| ID | Finding | Severity (CVSS) | Evidence | Fix | Retest |
|---|---|---|---|---|---|
| F1 | | | | | |

## What I learned
- 
