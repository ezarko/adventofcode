#!/usr/bin/perl

use strict;
use warnings;

use File::Slurp;

chomp(my @lines = read_file('input.txt'));

my($a,$p) = (0,0);
my %seen;

do {
  ++$seen{$p};
  if ($lines[$p] =~ /^nop /) {
    ++$p;
  } elsif ($lines[$p] =~ /^acc ([+-]\d+)$/) {
    $a += $1;
    ++$p;
  } elsif ($lines[$p] =~ /^jmp ([+-]\d+)$/) {
    $p += $1;
  } else {
    die $_;
  }
} while !$seen{$p};

print "$a\n";
