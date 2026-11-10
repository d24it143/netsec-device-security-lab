# 06 - Firmware, embedded and IoT security

## Goal
Practise firmware extraction and triage, and threat-model a networking device.

| File | Purpose |
|---|---|
| [firmware_analysis_workflow.md](firmware_analysis_workflow.md) | Step-by-step method and my findings |
| [firmware_triage.sh](firmware_triage.sh) | First-pass static checks on an extracted rootfs |
| [threat_model_router.md](threat_model_router.md) | STRIDE model of a router |

Firmware images are not committed (see `.gitignore`); record the download source and SHA-256 instead.

## Concepts covered
UART/JTAG/SPI flash, boot chain and secure boot, signed updates, hard-coded credentials, SBOM and CVE mapping, binary protections.

## What I learned
- 
