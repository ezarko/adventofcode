#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;
use File::Slurp;

my @trees = read_file('input.txt');

@trees = map {chomp;[split '']} @trees;
my $w = @{$trees[0]};
printf "%d\n", check_path(1, 1) * check_path(3, 1) * check_path(5, 1) * check_path(7, 1) * check_path(1, 2);

sub check_path {
  my($r, $d) = @_;

  my $x = 0;
  my $y = 0;
  my $t = 0;
  while ($y < $#trees) {
    $x += $r;
    $y += $d;
    $x -= $w if $x >= $w;
    $t += 1 if $trees[$y][$x] eq '#';
  }

  print "Right $r, down $d = $t\n";
  return $t;
}
