#!/usr/bin/perl

use strict;
use warnings;

use Digest::MD5 qw(md5_hex);

use constant KEY => 'iwrupvqb';

my($x,$h) = (-1);
do {
  $h = md5_hex(KEY . ++$x);
} while $h !~ /^00000/;

print "$x\n";
