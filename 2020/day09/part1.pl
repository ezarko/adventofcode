#!/usr/bin/perl

use strict;
use warnings;

use File::Slurp;

chomp(my @lines = read_file('input.txt'));
my @set = splice @lines, 0, 25;
check_next() while @lines;

sub check_next {
  for my $i (0..$#set) {
    for my $j (($i+1)..$#set) {
      next if $set[$i] == $set[$j];
      if ($lines[0] == $set[$i] + $set[$j]) {
        shift @set;
        push @set, shift @lines;
        return;
      }
    }
  }
  die "$lines[0]\n";
}
