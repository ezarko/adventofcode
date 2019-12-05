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
my($ox, $oy) = (0, 0);

START:
my @m = ();
my($x, $y, $c) = ($ox, $oy, 0);
my @i = ();

print "mapping first wire ($ox, $oy)\n";
for (@{$w[0]}) {
	if (/^R(\d+)$/) {
		for (1..$1) {
			++$x;
			++$c;
			$m[$x][$y] ||= $c;
		}
	} elsif (/^L(\d+)$/) {
		for (1..$1) {
			--$x;
			++$c;
			if ($x < 0) {
				$ox += 1000;
				goto START;
			}
			$m[$x][$y] ||= $c;
		}
	} elsif (/^U(\d+)$/) {
		for (1..$1) {
			++$y;
			++$c;
			$m[$x][$y] ||= $c;
		}
	} elsif (/^D(\d+)$/) {
		for (1..$1) {
			--$y;
			++$c;
			if ($y < 0) {
				$oy += 1000;
				goto START;
			}
			$m[$x][$y] ||= $c;
		}
	} else {
		die $_;
	}
}

print "mapping second wire ($ox, $oy)\n";
($x, $y, $c) = ($ox, $oy, 0);
for (@{$w[1]}) {
	if (/^R(\d+)$/) {
		for (1..$1) {
			++$x;
			++$c;
			push @i, $c + $m[$x][$y] if $m[$x][$y];
		}
	} elsif (/^L(\d+)$/) {
		for (1..$1) {
			--$x;
			++$c;
			if ($x < 0) {
				$ox += 1000;
				goto START;
			}
			push @i, $c + $m[$x][$y] if $m[$x][$y];
		}
	} elsif (/^U(\d+)$/) {
		for (1..$1) {
			++$y;
			++$c;
			push @i, $c + $m[$x][$y] if $m[$x][$y];
		}
	} elsif (/^D(\d+)$/) {
		for (1..$1) {
			--$y;
			++$c;
			if ($y < 0) {
				$oy += 1000;
				goto START;
			}
			push @i, $c + $m[$x][$y] if $m[$x][$y];
		}
	} else {
		die $_;
	}
}

print "determining result\n";
printf "%d\n", min @i;
