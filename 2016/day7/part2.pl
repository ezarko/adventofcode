#!/bin/perl

use strict;
use warnings;

my $count;

open INPUT, 'input.txt';
OUTER:
while (<INPUT>) {
	my $supernet = '';
	$supernet .= $1 while s/(\[[^\]]+\])/[]/;
	while (s/(.)(?!\1)(.)\1/$2$1/) {
		if ($supernet =~ /$2$1$2/) {
			++$count;
			next OUTER;
		}
	}
}
close INPUT;

print "$count\n";
