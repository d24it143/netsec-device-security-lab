# 01 - Networking and Wireshark

## Goal
Capture and analyse core network protocols using Wireshark and understand what each packet reveals.

## Setup
- **OS:** Kali Linux (VirtualBox)
- **Capture interface:** `eth0`
- **NAT IP:** `10.0.2.15/24`
- **NAT gateway:** `10.0.2.2`
- **Host-only IP:** `192.168.56.2/24`
- **Tools:** Wireshark, curl, dig, ping, traceroute

## Captures

| # | Test | Command | Display Filter | Evidence | Findings |
|---|---|---|---|---|---|
| 1 | TCP handshake | `curl -v http://neverssl.com -o /dev/null` | `tcp.flags.syn == 1` | `pcaps/tcp_handshake.pcapng` | Observed SYN, SYN-ACK, ACK, HTTP GET, HTTP 200 OK and FIN/ACK connection termination. SYN consumes one sequence number. |
| 2 | DNS query/response | `dig example.com` | `dns` | `pcaps/dns.pcapng` | Observed DNS A query and response with transaction ID `0x2882`. Also tested AAAA and TCP-based DNS queries. |
| 3 | ARP request/reply | `sudo ip neigh flush all` followed by `ping -c 1 10.0.2.2` | `arp` | `pcaps/arp.pcapng` | Observed ARP request (opcode 1) and reply (opcode 2). Gateway `10.0.2.2` resolved to MAC `52:54:00:12:35:00`. |
| 4 | ICMP and TTL | `ping -c 20 -i 0.3 8.8.8.8` | `icmp` | `pcaps/icmp.pcapng` | Observed Echo Request (Type 8), Echo Reply (Type 0), TTL values and ICMP Time Exceeded messages. Traceroute showed `10.0.2.2` as the first hop; later hops timed out. |
| 5 | HTTP vs HTTPS | `curl -s -d 'user=test&pass=demo123' http://httpbin.org/post -o /dev/null` and HTTPS equivalent | `http` / `tls` | `pcaps/http_vs_https.pcapng` | HTTP POST form fields were readable in the TCP stream. HTTPS showed a TLS Client Hello and encrypted Application Data. |

**Security note:** Only dummy credentials were used for HTTP/HTTPS testing. Packet captures should not contain real credentials, tokens or personal information.

## DNS Additional Tests

| Test | Command | Observation |
|---|---|---|
| IPv4 DNS | `dig example.com` | A record query over UDP port 53 |
| IPv6 DNS | `dig example.com AAAA` | AAAA response included `2606:4700:8d75:72db:f2d7:d9e:ef6b:ff98` |
| DNS over TCP | `dig +tcp example.com` | DNS query carried over TCP port 53 |

## ICMP and Traceroute Observations

- Echo Request: ICMP Type 8, Code 0.
- Echo Reply: ICMP Type 0, Code 0.
- Echo request observed with IPv4 TTL 64.
- Corresponding echo reply observed with IPv4 TTL 111.
- ICMP Time Exceeded: Type 11, Code 0.
- Traceroute identified the VirtualBox NAT gateway `10.0.2.2` as the first hop. Subsequent hops did not respond within the configured timeout.

## HTTP vs HTTPS Observations

### HTTP
- HTTP POST request sent to `httpbin.org`.
- Content type: `application/x-www-form-urlencoded`.
- TCP stream exposed the dummy form data:
  `user=test&pass=demo123`.
- Server returned HTTP 200 OK.

### HTTPS
- Observed TLS 1.3 Client Hello.
- Observed TLS Application Data in both client-to-server and server-to-client directions.
- Application data did not expose the submitted form fields as readable HTTP content.

## Protocol Hierarchy

The saved HTTPS capture contained:

| Protocol | Packets | Bytes |
|---|---:|---:|
| Ethernet | 7 | 98 |
| IPv4 | 7 | 140 |
| TCP | 7 | 140 |
| TLS | 7 | 2,116 |

- Total captured packets: 7
- Total captured bytes: 2,494
- TLS accounted for approximately 84.84% of captured bytes.

## Subnetting Practice

Method:
1. Calculate block size: `256 - subnet mask octet`.
2. Find the network address using the largest block multiple not exceeding the host address.
3. Calculate the broadcast address as the next network address minus one.
4. Calculate usable hosts as total addresses minus two (for conventional IPv4 subnets).

Verify using Python:

```bash
python3 -c "import ipaddress as i; n=i.ip_network('192.168.10.77/26',strict=False); print(n,n.broadcast_address,n.num_addresses-2)"
```

**Practice problems and answers:** Pending.

## What I Learned

- TCP establishes connections through the SYN, SYN-ACK and ACK handshake.
- SYN consumes one sequence number.
- DNS resolves domain names and supports both UDP and TCP transport.
- A records provide IPv4 addresses, while AAAA records provide IPv6 addresses.
- ARP resolves IPv4 addresses to MAC addresses on a local network.
- ICMP is useful for connectivity testing and diagnosing TTL expiration.
- Traceroute helps reveal responding network hops.
- HTTP form data can be exposed in readable network traffic.
- HTTPS uses TLS to encrypt application data in transit.
- Wireshark Protocol Hierarchy helps identify protocols and their contribution to captured traffic.

## Evidence Files

```text
01-networking-wireshark/
├── README.md
├── pcaps/
│   ├── tcp_handshake.pcapng
│   ├── dns.pcapng
│   ├── arp.pcapng
│   ├── icmp.pcapng
│   └── http_vs_https.pcapng
└── img/
```

## Pending Work

- [ ] Complete 10 subnetting exercises.
- [ ] Add relevant Wireshark screenshots to `img/`.
- [ ] Review and verify all packet captures.
- [ ] Commit and push final documentation and evidence.
