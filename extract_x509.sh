#! /bin/sh
# License: GPLv3+

mkdir -p pki-usgov-dod/cacerts
base=pki-usgov-dod/cacerts
for foo in pkcs7/*.cac pkcs7/*.p7c ; do
   openssl pkcs7 -inform DER -in $foo -print_certs -text > ${base}/pkcs7.txt
   ./pkcs7_split.pl ${base}/pkcs7.txt
   rm ${base}/pkcs7.txt
done

cp pkcs7/dodroot-med.cac pki-usgov-dod/cacerts/dodroot-med.crt
cp pkcs7/fcpca.crt pki-usgov-dod/cacerts/
# cer

