#!/usr/bin/perl

use strict;
use warnings;

use constant INPUT => 36000000;

my %e;

my($p,$h)=(0,0);
while ($p < INPUT) {
  $p = 0;
  for (reverse 1..++$h) {
    $p += $_ if ($h % $_) == 0 && ++$e{$_} <= 50;
  }
  $p *= 11;
}
print "$h\n";
