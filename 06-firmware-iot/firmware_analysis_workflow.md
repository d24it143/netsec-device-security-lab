# Firmware analysis workflow

1. **Obtain** firmware from a vendor/open project (for example OpenWrt downloads). Record the file name, version and SHA-256.
2. **Identify:** `file fw.bin`, `strings fw.bin | head`, `binwalk fw.bin`, `binwalk -E fw.bin` (entropy: high means compressed or encrypted).
3. **Extract:** `binwalk -e fw.bin`, then `unsquashfs` if needed.
4. **Static review:** run `./firmware_triage.sh <rootfs>`; read `/etc/init.d`, web root and CGI binaries.
5. **Component/CVE mapping:** list library versions (BusyBox, OpenSSL, kernel) and search CVE databases.
6. **Binary protections:** `checksec --file=<bin>` (NX, ASLR/PIE, canary, RELRO).
7. **Emulate/dynamic test (optional):** QEMU, Firmadyne/EMBA in a lab.
8. **Report:** finding, severity (CVSS), evidence, fix, retest.

## My analysis (fill in)
- Firmware: ____ (version ____, SHA-256 ____)
- Findings:

| ID | Finding | Evidence | Severity | Recommendation |
|---|---|---|---|---|
| 1 | | | | |
