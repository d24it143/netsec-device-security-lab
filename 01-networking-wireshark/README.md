# 01 - Networking and Wireshark

## Goal
Capture and analyse core protocol traffic so I can explain what each packet shows.

## Setup
- Kali Linux VM (VirtualBox), Wireshark on `eth0`
- Notes: my IP `____`, gateway `____`

## Captures
| # | Test | Command | Filter | pcap file | Findings |
|---|---|---|---|---|---|
| 1 | TCP handshake | `curl -s http://neverssl.com -o /dev/null` | `tcp.flags.syn==1` | `pcaps/tcp_handshake.pcapng` | |
| 2 | DNS query/response | `dig example.com` | `dns` | `pcaps/dns.pcapng` | |
| 3 | ARP request/reply | `ip neigh flush all; ping -c1 <gateway>` | `arp` | `pcaps/arp.pcapng` | |
| 4 | ICMP and TTL | `ping -c 4 8.8.8.8; sudo traceroute -I 8.8.8.8` | `icmp` | `pcaps/icmp.pcapng` | |
| 5 | HTTP vs HTTPS | `curl -d "user=test&pass=demo" http://httpbin.org/post` then https | `http` / `tls` | `pcaps/http_vs_https.pcapng` | |

Use only dummy credentials. Keep pcaps small and free of real personal data.

## Subnetting practice
Method: block size = 256 - mask octet value; network = largest multiple of block size at or below the host value; broadcast = next network - 1.
Verify with:
```bash
python3 -c "import ipaddress as i; n=i.ip_network('192.168.10.77/26',strict=False); print(n, n.broadcast_address, n.num_addresses-2)"
```

## What I learned
- 
