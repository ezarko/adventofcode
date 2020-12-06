#!/usr/bin/perl

use strict;
use warnings;

use File::Slurp;
use List::Util qw(sum);

chomp(my @data = read_file('input.txt'));

my @r = ({});
my @c = (0);
for my $p (@data) {
  if($p eq '') {
    push @r, {};
    push @c, 0;
    next;
  }

  ++$r[$#r]{$_} for split '', $p;
  ++$c[$#c];;
}

print sum(map {my($r,$c) = ($r[$_],$c[$_]);scalar grep {$r->{$_} == $c} keys(%$r)} 0..$#r)."\n";
