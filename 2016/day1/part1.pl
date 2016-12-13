#!/bin/perl

use strict;
use warnings;

my($x,$y,$d) = (0, 0, 0);

my @directions = (
	sub {$y += shift},
	sub {$x += shift},
	sub {$y -= shift},
	sub {$x -= shift},
);

$/ = undef;
open INPUT, "input.txt";
$_ = <INPUT>;
close INPUT;
s/\s*\r?\n$//;
for (split /,\s*/) {
	s/^([RL])(\d+)$// or die $_;
	$d += ($1 eq 'R') ? 1 : -1;
	$d -= 4 if $d > 3;
	$d += 4 if $d < 0;
	$directions[$d]->($2);
}

printf "%d\n", abs($x)+ abs($y);
