#!/usr/bin/perl

use strict;
use warnings;

my $t;

open(INFILE, 'input.txt') or die "Cannot open file input.txt for reading: $!";
while(<INFILE>) {
  chomp;
  @_ = split 'x';
  @_ = sort {$a <=> $b} ($_[0]*$_[1], $_[0]*$_[2], $_[1]*$_[2]);
  $t += 3 * $_[0] + 2 * $_[1] + 2 * $_[2];
}
close INFILE;

print "$t\n";
