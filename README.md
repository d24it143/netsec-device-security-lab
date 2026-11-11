# Network and Device Security Lab

Hands-on labs, automation scripts and write-ups covering network security, Linux security automation, cryptography/TLS and embedded/IoT firmware analysis. Built as a structured portfolio of what I have actually run and tested.

**Author:** Dhaval Varvariya (B.Tech IT, CSPIT, CHARUSAT) - GitHub: [@d24it143](https://github.com/d24it143)

> **Ethics:** Everything here is run only against systems I own or an intentionally vulnerable lab VM on an isolated host-only network. Do not use any of it against systems you do not have written permission to test.

## Contents and status

Status is updated honestly: **Planned**, **In progress** or **Done** (done means run, tested and written up with evidence).

| # | Folder | What it covers | Status |
|---|---|---|---|
| 1 | [01-networking-wireshark](01-networking-wireshark) | TCP/IP, DNS, ARP, ICMP, TLS captured and analysed in Wireshark | Done |
| 2 | [02-linux-fundamentals](02-linux-fundamentals) | Permissions, users, processes, logs, command cheat sheet | Done |
| 3 | [03-bash-security-toolkit](03-bash-security-toolkit) | Bash/Python scripts: failed-login monitor, Nmap wrapper, integrity checker, port audit, backup | Planned |
| 4 | [04-network-attacks-defences](04-network-attacks-defences) | Nmap, ARP spoofing, SYN flood, iptables, SSH hardening in a lab | Planned |
| 5 | [05-crypto-tls](05-crypto-tls) | OpenSSL, hashing, TLS handshake, cipher/cert testing | Planned |
| 6 | [06-firmware-iot](06-firmware-iot) | Firmware extraction and triage, STRIDE threat model of a router | Planned |
| 7 | [07-codeforge-hub-hardening](07-codeforge-hub-hardening) | Security review and fixes for a containerised web app | Planned |

## Skills demonstrated (mapped to evidence)

See [docs/jd-mapping.md](docs/jd-mapping.md) for the mapping of each skill to the folder where it is shown.

## How to use

```bash
git clone https://github.com/d24it143/netsec-device-security-lab.git
cd netsec-device-security-lab
chmod +x 03-bash-security-toolkit/*.sh 04-network-attacks-defences/*.sh 06-firmware-iot/*.sh
```

Each folder has its own README with the lab steps, commands, findings and lessons learned.

## Lab environment

- VirtualBox, Kali Linux (OVA), a vulnerable target VM on a host-only network
- Tools: Wireshark, tcpdump, Nmap, OpenSSL, iptables, binwalk, Ghidra/checksec, shellcheck
