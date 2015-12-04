#!/usr/bin/perl

use strict;
use warnings;

my $t;

open(INFILE, 'input.txt') or die "Cannot open file input.txt for reading: $!";
while(<INFILE>) {
  chomp;
  @_ = sort {$a <=> $b} split 'x';
  $t += $_[0] * 2 + $_[1] * 2 + $_[0] * $_[1] * $_[2];
}
close INFILE;

print "$t\n";
