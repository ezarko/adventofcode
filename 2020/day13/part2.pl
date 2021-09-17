#!/usr/bin/perl

use strict;
use warnings;

use File::Slurp;

chomp(my @lines = read_file('input.txt'));

my @p = split ',', $lines[1];
my $t = 100000000000000;
my $r = 1;
OUTER: while ($r) {
  for (0..$#p) {
    next if $p[$_] eq 'x';
    unless (($t + $_) % $p[$_] == 0) {
      ++$t;
      next OUTER;
    }
  }
  $r = 0;
}
print "$t\n";
