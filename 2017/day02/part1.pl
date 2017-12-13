#!/usr/bin/perl

use strict;
use warnings;

my $checksum = 0;
while (<>) {
	chomp;
	@_ = sort {$a <=> $b} split;
	$checksum += $_[$#_] - $_[0];
}
print "$checksum\n";
