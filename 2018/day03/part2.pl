#!/usr/bin/perl

use strict;
use warnings;

use List::Util qw( max );

my(@c, %c);

for (<>) {
	/^#(\d+) \@ (\d+),(\d+): (\d+)x(\d+)\r?\n$/ or die $_;
	my($c, $x, $y, $w, $h) = ($1, $2, $3, $4, $5);
	push @c, {c => $c, x => $x, y => $y, w => $w, h => $h};
	for (my $i = $x; $i < ($x + $w); ++$i) {
		for (my $j = $y; $j < ($y + $h); ++$j) {
			++$c{$i}{$j};
		}
	}
}

print map "$_->{c}\n", grep test($_), @c;

sub test {
	my $_ = shift;

	for (my $i = $_->{x}; $i < ($_->{x} + $_->{w}); ++$i) {
		for (my $j = $_->{y}; $j < ($_->{y} + $_->{h}); ++$j) {
			return undef if 1 < $c{$i}{$j};
		}
	}

	return 1;
}
