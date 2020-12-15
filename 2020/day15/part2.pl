#!/usr/bin/perl

use strict;
use warnings;

my @numbers = (0,13,1,8,6,15);

my %l = map {($numbers[$_] => $_)} 0..$#numbers;
my $n = 0;
my $c = @numbers;

while ($c < 29999999) {
  my $o = exists($l{$n}) ? $c - $l{$n} : 0;
  $l{$n} = $c++;
  $n = $o;
}

print "$n\n";
