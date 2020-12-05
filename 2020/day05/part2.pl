#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;
use File::Slurp;

chomp(my @data = read_file('input.txt'));
@data = sort {$a <=> $b} map idof($_), @data;
for (0..($#data-1)) {
  die $data[$_]+1 if $data[$_+1] == $data[$_] + 2;
}

sub idof {
  local $_ = shift @_;
  die $_ unless /^[FB]{7}[RL]{3}$/;
  tr/FBLR/0101/;
  unpack "S>*", pack "B16", "000000$_";
}
