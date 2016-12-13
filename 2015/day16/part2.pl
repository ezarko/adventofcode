#!/usr/bin/perl

use strict;
use warnings;

use integer;

my %a;

open(INFILE, 'input.txt') or die "Cannot open file input.txt for reading: $!";
while(<INFILE>) {
  s/^Sue (\d+): (.*?)\n/$2/ or die $_;
  my %f = map {(split ': ')} split ', ', $_;
  next if exists($f{children}) && $f{children} != 3;
  next if exists($f{cats}) && $f{cats} <= 7;
  next if exists($f{samoyeds}) && $f{samoyeds} != 2;
  next if exists($f{pomeranians}) && $f{pomeranians} >= 3;
  next if exists($f{akitas}) && $f{akitas} != 0;
  next if exists($f{vizslas}) && $f{vizslas} != 0;
  next if exists($f{goldfish}) && $f{goldfish} >= 5;
  next if exists($f{trees}) && $f{trees} <= 3;
  next if exists($f{cars}) && $f{cars} != 2;
  next if exists($f{perfumes}) && $f{perfumes} != 1;
  $a{$1} = \%f;
}
close INFILE;

use Data::Dumper; print Dumper \%a;
