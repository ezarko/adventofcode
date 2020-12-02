#!/usr/bin/perl

use strict;
use warnings;

use File::Slurp;

chomp(my @lines = read_file('input.txt'));
my $valid = 0;
for (@lines) {
  die $_ unless /^(\d+)-(\d+) ([a-z]): ([a-z]+)$/;
  my($p1, $p2, $letter, $password) = ($1, $2, $3, $4);
  my @matches = split '', $password;
  @matches = grep {$_ eq $letter} $matches[$p1-1], $matches[$p2-1];
  ++$valid if @matches == 1;
}
print "$valid\n";
