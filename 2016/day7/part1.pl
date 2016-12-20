#!/bin/perl

use strict;
use warnings;

my $count;

open INPUT, 'input.txt';
OUTER:
while (<INPUT>) {
	while (s/\[([^\]]+)\]/[]/) {
		local $_ = $1;
		next OUTER if /(.)(?!\1)(.)\2\1/;
	}
	++$count if /(.)(?!\1)(.)\2\1/;
}
close INPUT;

print "$count\n";
