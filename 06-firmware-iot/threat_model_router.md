# STRIDE threat model: small-office Wi-Fi router

**Components:** LAN clients, web admin UI, WAN interface, cloud management agent, firmware update server, USB port, UART header.

**Trust boundaries:** Internet to router, LAN client to admin UI, router to cloud, update server to router, physical access.

| STRIDE | Component | Threat | Mitigation | Priority |
|---|---|---|---|---|
| Spoofing | Update server | Fake update server | TLS with cert validation, signed images | High |
| Tampering | Firmware | Modified image installed | Secure boot, signature check, anti-rollback | High |
| Repudiation | Admin UI | Admin denies a config change | Audit logs to remote syslog | Medium |
| Information disclosure | Config backup | Plaintext passwords in backup | Encrypt, strip secrets | Medium |
| Denial of service | WAN services | Packet flood crashes daemon | Rate limits, watchdog | Medium |
| Elevation of privilege | CGI scripts | Command injection gives root | Input validation, drop privileges | High |

Add at least 6 more threats of your own (UART root shell, default credentials, UPnP exposure, Telnet, weak TLS, supply chain).
