#!/usr/bin/perl

use strict;
use warnings;

my $t = 0;
while (<>) {
	chomp;
	do {
		$_ = int($_/3)-2;
		$t += $_;
	} while ($_ > 8);
}
print "$t\n";
