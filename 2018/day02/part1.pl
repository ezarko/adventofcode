#!/usr/bin/perl

use strict;
use warnings;

my($two, $three);

while (<>) {
	chomp;
	my %l;
	for (split '', $_) {
		++$l{$_};
	}
	++$two if grep {$_ == 2} values %l;
	++$three if grep {$_ == 3} values %l;
}

printf "%d\n", $two * $three;
