#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;
use File::Slurp;

chomp(my @lines = read_file('input.txt'));
my $count = 0;
for (my $i = 1; $i < @lines; ++$i) {
  ++$count if $lines[$i] > $lines[$i-1];
}

print "$count\n";
