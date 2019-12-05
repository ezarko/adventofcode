#!/usr/bin/perl

use strict;
use warnings;

my $c;
for (158126..624574) {
	next unless /([0-9])\1/;
	my @d = split '';
	next if $d[0] > $d[1] || $d[1] > $d[2] || $d[2] > $d[3] || $d[3] > $d[4] || $d[4] > $d[5];
	my %d;
	++$d{$d[$_]} for 0..5;
	next unless grep /^2$/, values %d;
	++$c;
}
print "$c\n";
