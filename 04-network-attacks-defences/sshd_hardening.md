# SSH hardening (`/etc/ssh/sshd_config`)

```
PermitRootLogin no
PasswordAuthentication no
PubkeyAuthentication yes
MaxAuthTries 3
LoginGraceTime 30
AllowUsers <your-user>
X11Forwarding no
```
Validate and reload: `sudo sshd -t && sudo systemctl reload ssh`.
Test from a second session before closing the first one.
