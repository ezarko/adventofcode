#!/usr/bin/perl

use strict;
use warnings;

use File::Slurp;

chomp(my @lines = read_file('input.txt'));

my($x,$y,$dx,$dy) = (0,0,10,1);
for (@lines) {
  /^([NESWLRF])(\d+)$/ or die $_;
  if ($1 eq 'N') {
    $dy += $2;
  } elsif ($1 eq 'E') {
    $dx += $2;
  } elsif ($1 eq 'S') {
    $dy -= $2;
  } elsif ($1 eq 'W') {
    $dx -= $2;
  } elsif ($1 eq 'L') {
    if ($2 == 90) {
      my $t = $dx;
      $dx = -$dy;
      $dy = $t;
    } elsif ($2 == 180) {
      my $t = $dx;
      $dx *= -1;
      $dy *= -1;
    } elsif ($2 == 270) {
      my $t = $dx;
      $dx = $dy;
      $dy = -$t;
    } else {
      die $_;
    }
  } elsif ($1 eq 'R') {
    if ($2 == 90) {
      my $t = $dx;
      $dx = $dy;
      $dy = -$t;
    } elsif ($2 == 180) {
      my $t = $dx;
      $dx *= -1;
      $dy *= -1;
    } elsif ($2 == 270) {
      my $t = $dx;
      $dx = -$dy;
      $dy = $t;
    } else {
      die $_;
    }
  } elsif ($1 eq 'F') {
    $x += $2 * $dx;
    $y += $2 * $dy;
  }
  #print "S:$x,$y $dx,$dy\n";
}
printf "%d\n", abs($x) + abs($y);
