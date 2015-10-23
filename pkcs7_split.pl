#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: pkcs7_split.pl
#
#        USAGE: ./pkcs7_split.pl  
#
#  DESCRIPTION: split a text based pkcs7 file into x.509 certs
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: SPC Steve J Pollei, 
# ORGANIZATION: United States Army Reserve
#      VERSION: 0.0.2
#     REVISION: ---
#     # License: GPLv3+
#===============================================================================

use strict;
use warnings;
use utf8;
use 5.018;
#use English;

#use Digest::CRC qw(crc64 crc32 crc16);
use Digest::CRC qw(crc16);
# dnf install perl-Digest-CRC

# $ARGV[0];
my $out_base='';
my $out_name='';
my $line='';
my $buf='';
my $pem_buf='';
my $buf_crc=0;
my $pem_buf_crc=0;
my $infil;
my $outfil;

#say $ARGV[0];
if ($ARGV[0] =~ /^([a-zA-Z0-9\/_.\-]{1,59}\/)pkcs7\.txt/ ) {
  $out_base=$1 ;
  #say $out_base;
}
else {die; }

#say $out_base;

open($infil, '<', $ARGV[0]);
#open(my $outfil, $ARGV[0], '<');

my $cn='error';
my $serial_num=0;
while ($line=<$infil>) {
  if ($buf eq '' && $line =~ /^$/ ) { next; }
  $pem_buf .= $line;
  if ($line =~ /Subject:.*(CN|OU)=([a-zA-Z 0-9.\-]{1,63})$/ ) {
    $cn =$2;
    $cn  =~ s/[ .]/_/g;
    #say $cn, ' ', crc16($cn);
  }
  if ($line =~ /Serial Number:\s*([0-9]{1,12})\s/ ) {
    $serial_num =$1;
  }
  # Serial Number: 1312391187 (0x4e398013)
  #next;
  if ($line =~ /-----BEGIN CERTIFICATE-----/ ) {
    #say 'begin';
    $buf_crc=crc16($buf);
    $out_name= $out_base . $cn . '-' . $serial_num . '-' . $buf_crc . '.txt';
    #say $out_name;
    open($outfil, '>', $out_name);
    print $outfil $buf;
    close($outfil);
    $pem_buf=$line;
    $buf='';
  }
  $buf .= $line;
  if ($line =~ /-----END CERTIFICATE-----/ ) {
    #say 'end';
    #$buf_crc=crc16($buf);
    $out_name= $out_base . $cn . '-' . $serial_num . '-' . $buf_crc . '.pem';
    open($outfil, '>', $out_name);
    print $outfil $pem_buf;
    close($outfil);
    $buf='';
    $pem_buf='';
    $cn='ERROR';
    $serial_num='ERROR';
    $buf_crc='ERROR';
  }
}

