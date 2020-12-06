#!/usr/bin/perl

use strict;
use warnings;

use File::Slurp;
use List::Util qw(sum);

chomp(my @data = read_file('input.txt'));

my @r = ({});
for my $p (@data) {
  if($p eq '') {
    push @r, {};
    next;
  }

  ++$r[$#r]{$_} for split '', $p;
}

print sum(map scalar(keys(%$_)), @r)."\n";
