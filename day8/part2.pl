#!/usr/bin/perl

use strict;
use warnings;

my($c, $m);

open(INFILE, 'input.txt') or die "Cannot open file input.txt for reading: $!";
while(<INFILE>) {
  chomp;
  $c += length;
  s/([\\"])/\\$1/g;
  $_ = '"' . $_ . '"';
  $m += length;
}
close INFILE;

printf "%d\n", $m - $c;
