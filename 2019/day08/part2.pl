#!/usr/bin/perl

use strict;
use warnings;

$_ = <>;
chomp;
my @i = split '';
my @l;

while (@i >= 300 && count_digits(2, @i[0..149])) {
	for (0..149) {
		$i[$_] = $i[$_+150] if $i[$_] == 2;
	}
	splice(@i, 150, 150);
}

print join('', map $_ ? '*' : ' ', @i[0..24]), "\n",
      join('', map $_ ? '*' : ' ', @i[25..49]), "\n",
      join('', map $_ ? '*' : ' ', @i[50..74]), "\n",
      join('', map $_ ? '*' : ' ', @i[75..99]), "\n",
      join('', map $_ ? '*' : ' ', @i[100..124]), "\n",
      join('', map $_ ? '*' : ' ', @i[125..149]), "\n";

sub count_digits {
	my $comparison = shift @_;
	return scalar grep {$_ == $comparison} @_;
}
