#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;
use File::Slurp;
use List::Util qw(min);

chomp(my @lines = read_file('input.txt'));

my %buses = map {
  ((($lines[0] % $_ == 0) ? $lines[0] : (int($lines[0] / $_) + 1) * $_) => $_)
} grep {
  /^\d+$/
} split ',', $lines[1];

my $f = min(keys %buses);
print $buses{$f} * ($f - $lines[0]) . "\n";
