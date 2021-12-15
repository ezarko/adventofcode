#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;
use File::Slurp;

chomp(my @lines = read_file('input.txt'));
my $count = 0;
my $last = $lines[0] + $lines[1] + $lines[2];
for (my $i = 3; $i < @lines; ++$i) {
  my $current = $lines[$i-2] + $lines[$i-1] + $lines[$i];
  ++$count if $current > $last;
  $last = $current;
}

print "$count\n";
