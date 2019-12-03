#!/usr/bin/perl

use strict;
use warnings;

my $t = 0;
while(<>) {
	chomp;
	$_ = int($_/3)-2;
	$t += $_;
}
print "$t\n";
