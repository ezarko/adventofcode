#!/usr/bin/perl

use strict;
use warnings;

chomp(my @l = <>);

for (@l) {
	for (my $i = 0; $i < 26; ++$i) {
		my @r = split '', $_;
		$r[$i] = '.';
		my $r = '^' . join('', @r) . '$';
		$r = qr/$r/;
		print join("\n", grep($_ =~ $r, @l), '') if 2 == grep {$_ =~ $r} @l;
	}
}
//TODO: correct output
