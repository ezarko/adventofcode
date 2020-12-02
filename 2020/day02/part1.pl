#!/usr/bin/perl

use strict;
use warnings;

use File::Slurp;

chomp(my @lines = read_file('input.txt'));
my $valid = 0;
for (@lines) {
  die $_ unless /^(\d+)-(\d+) ([a-z]): ([a-z]+)$/;
  my($min, $max, $letter, $password) = ($1, $2, $3, $4);
  my @matches = grep {$_ eq $letter} split '', $password;
  ++$valid if @matches >= $min && @matches <= $max;
}
print "$valid\n";
