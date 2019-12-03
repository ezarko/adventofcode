#!/usr/bin/perl

use strict;
use warnings;

$_ = <>;
chomp;
my @m = split ',';

for my $noun (0..99) {
	for my $verb (0..99) {
		my @s = @m;
		my $p = 0;
		$s[1] = $noun;
		$s[2] = $verb;

		while ($s[$p] != 99) {
			if ($s[$p] == 1) {
				$s[$s[$p+3]] = $s[$s[$p+1]] + $s[$s[$p+2]];
				$p += 4;
			} elsif ($s[$p] == 2) {
				$s[$s[$p+3]] = $s[$s[$p+1]] * $s[$s[$p+2]];
				$p += 4;
			} else {
				die "$p:" . join(',', @s) . "\n";
			}
		}
		printf "%d\n", 100 * $noun + $verb if $s[0] == 19690720;
	}
}
