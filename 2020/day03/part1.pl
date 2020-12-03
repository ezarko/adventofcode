#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;
use File::Slurp;

my @trees = read_file('input.txt');

@trees = map {chomp;[split '']} @trees;
my $w = @{$trees[0]};
my $x = 0;
my $y = 0;
my $t = 0;
while ($y < $#trees) {
  $x += 3;
  $y += 1;
  $x -= $w if $x >= $w;
  $t += 1 if $trees[$y][$x] eq '#';
}
print "$t\n";
