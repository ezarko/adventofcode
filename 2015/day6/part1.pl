#!/usr/bin/perl

use strict;
use warnings;

my @l;

open(INFILE, 'input.txt') or die "Cannot open file input.txt for reading: $!";
while(<INFILE>) {
  die $_ unless /^(turn on|toggle|turn off) (\d+),(\d+) through (\d+),(\d+)\n$/;
  if ($1 eq 'turn on') {
    for my $x ($2..$4) {
      for my $y ($3..$5) {
        $l[$x*1000+$y] = 1;
      }
    }
  } elsif ($1 eq 'turn off') {
    for my $x ($2..$4) {
      for my $y ($3..$5) {
        $l[$x*1000+$y] = 0;
      }
    }
  } else {
    for my $x ($2..$4) {
      for my $y ($3..$5) {
        $l[$x*1000+$y] = !$l[$x*1000+$y];
      }
    }
  }
}
close INFILE;

print scalar(grep {$_} @l) . "\n";
