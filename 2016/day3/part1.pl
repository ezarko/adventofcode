#!/bin/perl

use strict;
use warnings;

my $possible = 0;

open INPUT, 'input.txt';
while(<INPUT>) {
	chomp;
	@_ = map {0 + $_} split;
	die unless @_ == 3;
	++$possible if ($_[0] + $_[1] > $_[2]) && ($_[0] + $_[2] > $_[1]) && ($_[1] + $_[2] > $_[0]);
}
close INPUT;

print "$possible\n";
