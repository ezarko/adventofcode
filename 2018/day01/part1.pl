#!/usr/bin/perl

use strict;
use warnings;

my $v = 0;

while (<>) {
	chomp;
	$v += $_;
}

print "$v\n";
