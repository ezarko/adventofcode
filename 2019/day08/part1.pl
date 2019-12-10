#!/usr/bin/perl

use strict;
use warnings;

$_ = <>;
chomp;
my @i = split '';
my @l;
my $z = 151;

while (@i) {
	die unless @i >= 150;
	my $zero_count = count_digits(0, @i[0..149]);
	if ($zero_count < $z) {
		$z = $zero_count;
		@l = @i[0..149];
	}
	splice(@i, 0, 150);
}

printf "%d\n", count_digits(1, @l) * count_digits(2, @l);

sub count_digits {
	my $comparison = shift @_;
	return scalar grep {$_ == $comparison} @_;
}
