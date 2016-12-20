#!/bin/perl

use strict;
use warnings;

open INPUT, 'input.txt';
$_ = <INPUT>;
close INPUT;

s/\s+//sg;

sub get_length {
	local $_ = shift;
	my $l = 0;

	while (length $_) {
		$l += length $1 if s/^([^(]*)//;
		if (s/^\((\d+)x(\d+)\)//) {
			my($c, $r) = ($1, $2);
			$l += $r * get_length(substr($_, 0, $c));
			$_ = substr $_, $c;
		}
	}
	return $l;
}

print get_length($_)."\n";
