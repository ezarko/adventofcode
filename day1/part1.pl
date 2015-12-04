#!/usr/bin/perl

use strict;
use warnings;

open(INFILE, 'input.txt') or die "Cannot open file input.txt for reading: $!";
$_ = <INFILE>;
close INFILE;

s/\(\)|\)\(//g while /\(\)|\)\(/;
my $d = /^\(/ ? 1 : -1;
$_ = length($_) * $d;

print "$_\n";
