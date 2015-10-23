#! /bin/sh
# License: GPLv3+

mkdir -p pkcs7
mkdir -p x509
cd pkcs7
wget --input-file=../wget_fetchlist.txt --timeout=45 --quota=550k -nc

