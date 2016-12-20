#!/bin/perl

use strict;
use warnings;

open INPUT, 'input.txt';
$_ = <INPUT>;
close INPUT;

s/\s+//sg;

my $out = '';
while (length $_) {
	$out .= $1 if s/^([^(]*)//;
	if (s/^\((\d+)x(\d+)\)//) {
		$out .= substr($_, 0, $1) x $2;
		$_ = substr $_, $1;
	}
}
print length($out)."\n";
