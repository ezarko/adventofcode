#!/usr/bin/perl

use strict;
use warnings;

my $t;

open(INFILE, 'input.txt') or die "Cannot open file input.txt for reading: $!";
while(<INFILE>) {
  chomp;
  next unless /([a-z]{2}).*\1/;
  next unless /([a-z]).\1/;
  ++$t;
}
close INFILE;

print "$t\n";
