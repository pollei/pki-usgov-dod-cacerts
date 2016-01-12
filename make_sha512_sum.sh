# !/bin/bash
sha512sum pkcs7/* pki-usgov-dod/cacerts/*.pem x509/* | sort --key 2 > sha512sums.txt
