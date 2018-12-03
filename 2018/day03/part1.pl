#!/usr/bin/perl

use strict;
use warnings;

use List::Util qw( max );

my %c;

for (<>) {
	/^#(\d+) \@ (\d+),(\d+): (\d+)x(\d+)\r?\n$/ or die $_;
	my($c, $x, $y, $w, $h) = ($1, $2, $3, $4, $5);
	for (my $i = $x; $i < ($x + $w); ++$i) {
		for (my $j = $y; $j < ($y + $h); ++$j) {
			++$c{$i}{$j};
		}
	}
}

printf "%d\n", scalar grep {$_ > 1} map {values %$_} values %c;
