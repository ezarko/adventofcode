#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;
use File::Slurp;

my $data = read_file('input.txt');

my $count = grep {
  defined($_->{byr}) &&
  defined($_->{iyr}) &&
  defined($_->{eyr}) &&
  defined($_->{hgt}) &&
  defined($_->{hcl}) &&
  defined($_->{ecl}) &&
  defined($_->{pid})
} map {
  s/\n/ /g;
  my %p = map {(split ':')} split ' ';
  \%p;
} split "\n\n", $data;

print "$count\n";
