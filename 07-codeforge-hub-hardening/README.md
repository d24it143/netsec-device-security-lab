# 07 - CodeForge Hub: security review and hardening

Security review of CodeForge Hub, a containerised collaborative code editor (Next.js, Node.js/Express, Socket.IO, Yjs, Docker, Supabase).

> The application repository lives at https://github.com/Rajani-Meet/CodeForge-Hub. Do the changes in a fork or branch you control and link the commits here. Be clear about which parts you built and which you reviewed.

## Findings and fixes (before and after)

| ID | Finding | Severity | How I verified | Fix | Retest |
|---|---|---|---|---|---|
| 1 | Collaboration WebSocket and preview proxy lack authentication | High | Connect without a token | Signed short-lived ticket / auth middleware | |
| 2 | CORS allows any origin containing "localhost" | Medium | `curl -H "Origin: https://evil-localhost.com"` | Exact allow-list, production-safe config | |
| 3 | Container ports bound on all interfaces | High | `nmap` from another host | Bind to `127.0.0.1`, authenticated proxy | |
| 4 | Containers run as root, no CapDrop/PidsLimit | High | `docker inspect` | Non-root user, `CapDrop ALL`, `PidsLimit`, `no-new-privileges` | |
| 5 | Path check uses string prefix match | Medium | Sibling-prefix path test | `realpath` plus separator-aware check | |
| 6 | No rate limiting or security headers | Medium | Repeated requests | `helmet`, `express-rate-limit` | |

Fill in the last two columns only after you have run each test and fix. Add screenshots or command output to an `evidence/` folder.

## Pipeline additions (optional)
- `npm audit`, `gitleaks`, CodeQL, `trivy image` in GitHub Actions with pinned action versions.

## What I learned
- 
