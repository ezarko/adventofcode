#!/usr/bin/perl

use strict;
use warnings;

my $v = 0;

chomp(my @l = <>);
my %seen = (
	0 => 1
);

while ($seen{$v} < 2) {
	for (@l) {
		$v += $_;
		last if ++$seen{$v} > 1;
	}
}

print "$v\n";
