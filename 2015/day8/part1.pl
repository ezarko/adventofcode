#!/usr/bin/perl

use strict;
use warnings;

my($c, $m);

open(INFILE, 'input.txt') or die "Cannot open file input.txt for reading: $!";
while(<INFILE>) {
  chomp;
  $c += length;
  s/^"// or die;
  s/"$// or die;
  s/\\([\\"])/$1/g;
  s/\\x([0-9a-f]{2})/chr hex $1/egi;
  $m += length;
}
close INFILE;

printf "%d\n", $c - $m;
