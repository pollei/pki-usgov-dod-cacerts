#! /bin/sh
# License: GPLv3+

mkdir -p pkcs7
mkdir -p x509
# cd pkcs7
# wget --input-file=../wget_fetchlist.txt --timeout=45 --quota=550k -nc

# exit
wget --input-file=- --timeout=45 --quota=550k -nc --directory-prefix=pkcs7 <<HERE_PKCS7
http://dodpki.c3pki.chamb.disa.mil/rel3_dodroot_2048.cac
http://dodpki.c3pki.chamb.disa.mil/dodeca.cac
http://dodpki.c3pki.chamb.disa.mil/dodeca2.cac
http://dodpki.c3pki.chamb.disa.mil/rel3_dodroot_1024_retired.cac
http://http.fpki.gov/fcpca/caCertsIssuedByfcpca.p7c
http://http.fpki.gov/fcpca/caCertsIssuedTofcpca.p7c
http://http.fpki.gov/sha1frca/caCertsIssuedBysha1frca.p7c
HERE_PKCS7

wget --input-file=- --timeout=45 --quota=550k -nc --directory-prefix=x509 <<HERE_X509
http://http.fpki.gov/fcpca/fcpca.crt
http://dodpki.c3pki.chamb.disa.mil/dodroot-med.cac
HERE_X509
