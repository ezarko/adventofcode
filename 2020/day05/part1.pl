#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;
use File::Slurp;

#print idof("FBFBBFFRLR")."\n"; # row 44, column 5, seat ID 357.
#print idof("BFFFBBFRRR")."\n"; # row 70, column 7, seat ID 567.
#print idof("FFFBBBFRRR")."\n"; # row 14, column 7, seat ID 119.
#print idof("BBFFBBFRLL")."\n"; # row 102, column 4, seat ID 820.
chomp(my @data = read_file('input.txt'));
@data = sort {$b <=> $a} map idof($_), @data;
print shift(@data)."\n";

sub idof {
  local $_ = shift @_;
  die $_ unless /^[FB]{7}[RL]{3}$/;
  tr/FBLR/0101/;
  unpack "S>*", pack "B16", "000000$_";
}
