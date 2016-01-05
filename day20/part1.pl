#!/usr/bin/perl

use strict;
use warnings;

use constant INPUT => 36000000;

my($p,$h)=(0,0);
while ($p < INPUT) {
  $p = 0;
  for (reverse 1..++$h) {
    $p += $_ unless $h % $_;
  }
  $p *= 10;
}
print "$h\n";
