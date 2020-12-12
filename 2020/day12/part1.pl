#!/usr/bin/perl

use strict;
use warnings;

use File::Slurp;

chomp(my @lines = read_file('input.txt'));

my($x,$y,$h) = (0,0,90);
for (@lines) {
  /^([NESWLRF])(\d+)$/ or die $_;
  if ($1 eq 'N' || ($1 eq 'F' && $h == 0)) {
    $x += $2;
  } elsif ($1 eq 'E' || ($1 eq 'F' && $h == 90)) {
    $y += $2;
  } elsif ($1 eq 'S' || ($1 eq 'F' && $h == 180)) {
    $x -= $2;
  } elsif ($1 eq 'W' || ($1 eq 'F' && $h == 270)) {
    $y -= $2;
  } elsif ($1 eq 'L') {
    $h -= $2;
    $h += 360 if $h < 0;
  } elsif ($1 eq 'R') {
    $h += $2;
    $h -= 360 if $h >= 360;
  }
}
printf "%d\n", abs($x) + abs($y);
