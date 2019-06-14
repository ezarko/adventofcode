#!/usr/bin/perl

use strict;
use warnings;

my %j;

while (<>) {
	/^Step ([A-Z]) must be finished before step ([A-Z]) can begin\./ or die $_;
	$j{$1} ||= {l=>$1,d=>{}};
	$j{$2} ||= {l=>$2,d=>{}};
	$j{$2}{d}{$1} = 1;
}

while (%j) {
	my($n) = sort map {$_->{l}} grep {!%{$_->{d}}} values %j;
	print $n;
	delete $j{$n};
	delete $j{$_}{d}{$n} for keys %j;
}
print "\n";
