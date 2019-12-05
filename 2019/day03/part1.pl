#!/usr/bin/perl

use strict;
use warnings;

use List::Util qw/min/;

my @w;

while(<>) {
	chomp;
	push @w, [split ','];
}
die unless @w == 2;
my($ox, $oy) = (10000, 20000);

START:
my @m = ();
my($x, $y) = ($ox, $oy);
my @i = ();

print "mapping first wire ($ox, $oy)\n";
for (@{$w[0]}) {
	if (/^R(\d+)$/) {
		for (1..$1) {
			++$x;
			$m[$x][$y] = 1;
		}
	} elsif (/^L(\d+)$/) {
		for (1..$1) {
			--$x;
			if ($x < 0) {
				$ox += 10;
				goto START;
			}
			$m[$x][$y] = 1;
		}
	} elsif (/^U(\d+)$/) {
		for (1..$1) {
			++$y;
			$m[$x][$y] = 1;
		}
	} elsif (/^D(\d+)$/) {
		for (1..$1) {
			--$y;
			if ($y < 0) {
				$oy += 10;
				goto START;
			}
			$m[$x][$y] = 1;
		}
	} else {
		die $_;
	}
}

print "mapping second wire ($ox, $oy)\n";
($x, $y) = ($ox, $oy);
for (@{$w[1]}) {
	if (/^R(\d+)$/) {
		for (1..$1) {
			++$x;
			push @i, [$x, $y] if $m[$x][$y];
		}
	} elsif (/^L(\d+)$/) {
		for (1..$1) {
			--$x;
			if ($x < 0) {
				$ox += 10;
				goto START;
			}
			push @i, [$x, $y] if $m[$x][$y];
		}
	} elsif (/^U(\d+)$/) {
		for (1..$1) {
			++$y;
			push @i, [$x, $y] if $m[$x][$y];
		}
	} elsif (/^D(\d+)$/) {
		for (1..$1) {
			--$y;
			if ($y < 0) {
				$oy += 10;
				goto START;
			}
			push @i, [$x, $y] if $m[$x][$y];
		}
	} else {
		die $_;
	}
}

print "determining result\n";
printf "%d\n", min map abs($_->[0]-$ox) + abs($_->[1]-$oy), @i;
