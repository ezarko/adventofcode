#!/usr/bin/perl

use strict;
use warnings;

$_ = <>;
chomp;
my @s = split ',';
my $p = 0;

$s[1] = 12;
$s[2] = 2;

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

print "$s[0]\n";
