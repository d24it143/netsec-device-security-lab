# OpenSSL and TLS commands

```bash
# Hashing
sha256sum file.txt
openssl dgst -sha256 file.txt

# Symmetric encryption (AES-256-CBC with PBKDF2)
openssl enc -aes-256-cbc -pbkdf2 -salt -in secret.txt -out secret.enc
openssl enc -d -aes-256-cbc -pbkdf2 -in secret.enc -out secret.dec

# Key pair and signature
openssl genpkey -algorithm RSA -pkeyopt rsa_keygen_bits:2048 -out priv.pem
openssl pkey -in priv.pem -pubout -out pub.pem
openssl dgst -sha256 -sign priv.pem -out sig.bin file.txt
openssl dgst -sha256 -verify pub.pem -signature sig.bin file.txt

# Inspect a server certificate chain and negotiated protocol
openssl s_client -connect example.com:443 -servername example.com </dev/null
openssl s_client -connect example.com:443 -tls1_3 </dev/null | head -20

# Cipher/protocol audit
nmap --script ssl-enum-ciphers -p 443 example.com
```
Test only servers you own or public sites for read-only inspection.
