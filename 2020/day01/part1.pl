#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;
use File::Slurp;

chomp(my @lines = read_file('input.txt'));
for my $i (0..$#lines) {
  for my $j (($i+1)..$#lines) {
    if ($lines[$i] + $lines[$j] == 2020) {
      printf "%d\n", $lines[$i] * $lines[$j];
      exit;
    }
  }
}
