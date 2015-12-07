#!/usr/bin/perl

use strict;
use warnings;

my $t;

open(INFILE, 'input.txt') or die "Cannot open file input.txt for reading: $!";
while(<INFILE>) {
  chomp;
  next if /(ab|cd|pq|xy)/;
  next unless /([a-z])\1/;
  next unless /[aeiou].*[aeiou].*[aeiou]/;
  ++$t;
}
close INFILE;

print "$t\n";
