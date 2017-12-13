#!/usr/bin/perl

use strict;
use warnings;

my $checksum = 0;
while (<>) {
	chomp;
	@_ = sort {$a <=> $b} split;
	while (@_ > 2) {
		for (1..$#_) {
			unless ($_[$_]%$_[0]) {
				@_ = ($_[0], $_[$_]);
				last;
			}
		}
		shift @_ unless @_ == 2;
	}
	$checksum += $_[1] / $_[0];
}
print "$checksum\n";
