#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;
use File::Slurp;

my $data = read_file('input.txt');

my $count = grep {
  defined($_->{byr}) && $_->{byr} =~ /^(\d{4})$/ && $1 >= 1920 && $1 <= 2002 &&
  defined($_->{iyr}) && $_->{iyr} =~ /^(\d{4})$/ && $1 >= 2010 && $1 <= 2020 &&
  defined($_->{eyr}) && $_->{eyr} =~ /^(\d{4})$/ && $1 >= 2020 && $1 <= 2030 &&
  defined($_->{hgt}) && $_->{hgt} =~ /^(\d+)(cm|in)$/ && ($2 eq 'cm' ? ($1 >= 150 && $1 <= 193) : ($1 >= 59 && $1 <= 76)) &&
  defined($_->{hcl}) && $_->{hcl} =~ /^#[0-9a-f]{6}$/ &&
  defined($_->{ecl}) && $_->{ecl} =~ /^(amb|blu|brn|gry|grn|hzl|oth)$/ &&
  defined($_->{pid}) && $_->{pid} =~ /^(\d{9})$/
} map {
  s/\n/ /g;
  my %p = map {(split ':')} split ' ';
  \%p;
} split "\n\n", $data;

print "$count\n";
