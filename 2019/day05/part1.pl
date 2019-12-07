#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;

$_ = <>;
chomp;
my @s = split ',';
my $p = 0;

while ($s[$p] != 99) {
	if ($s[$p] == 1) {
		$s[$s[$p+3]] = $s[$s[$p+1]] + $s[$s[$p+2]];
		$p += 4;
	} elsif ($s[$p] == 2) {
		$s[$s[$p+3]] = $s[$s[$p+1]] * $s[$s[$p+2]];
		$p += 4;
	} elsif ($s[$p] == 3) {
		chomp($s[$s[$p+1]] = <>);
		$p += 2;
	} elsif ($s[$p] == 4) {
		print "$s[$s[$p+1]]\n";
		$p += 2;
	} elsif ($s[$p] == 101) {
		$s[$s[$p+3]] = $s[$p+1] + $s[$s[$p+2]];
		$p += 4;
	} elsif ($s[$p] == 102) {
		$s[$s[$p+3]] = $s[$p+1] * $s[$s[$p+2]];
		$p += 4;
	} elsif ($s[$p] == 104) {
		print "$s[$p+1]\n";
		$p += 2;
	} elsif ($s[$p] == 1001) {
		$s[$s[$p+3]] = $s[$s[$p+1]] + $s[$p+2];
		$p += 4;
	} elsif ($s[$p] == 1002) {
		$s[$s[$p+3]] = $s[$s[$p+1]] * $s[$p+2];
		$p += 4;
	} elsif ($s[$p] == 1101) {
		$s[$s[$p+3]] = $s[$p+1] + $s[$p+2];
		$p += 4;
	} elsif ($s[$p] == 1102) {
		$s[$s[$p+3]] = $s[$p+1] * $s[$p+2];
		$p += 4;
	} else {
		die Dumper @s, $p;
	}
}
