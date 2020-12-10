#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;
use File::Slurp;

chomp(my @lines = read_file('input.txt'));
@lines = sort {$a <=> $b} @lines;

my($last,$one,$three) = (0,0,1);
while (@lines) {
  if ($lines[0] - $last == 1) {
    ++$one;
  } elsif ($lines[0] - $last == 3) {
    ++$three;
  } else {
    die Dumper $last, \@lines;
  }
  $last = shift @lines;
}
printf "%d\n", $one * $three;
