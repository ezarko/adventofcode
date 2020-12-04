#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;
use File::Slurp;

my $data = read_file('input.txt');

my $count = grep {
  defined($_->{byr}) && $_->{byr} =~ /^(19[2-9]\d|200[0-2])$/ &&
  defined($_->{iyr}) && $_->{iyr} =~ /^20(1\d|20)$/ &&
  defined($_->{eyr}) && $_->{eyr} =~ /^20(2\d|30)$/ &&
  defined($_->{hgt}) && $_->{hgt} =~ /^((1[5-8]\d|19[0-3])cm|(59|6\d|7[0-6])in)$/ &&
  defined($_->{hcl}) && $_->{hcl} =~ /^#[0-9a-f]{6}$/ &&
  defined($_->{ecl}) && $_->{ecl} =~ /^(amb|blu|brn|gry|grn|hzl|oth)$/ &&
  defined($_->{pid}) && $_->{pid} =~ /^(\d{9})$/
} map {
  s/\n/ /g;
  my %p = map {(split ':')} split ' ';
  \%p;
} split "\n\n", $data;

print "$count\n";
