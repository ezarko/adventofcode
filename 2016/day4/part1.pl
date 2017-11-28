#!/bin/perl

use strict;
use warnings;

my $sum = 0;

open INPUT, 'input.txt';
while (<INPUT>) {
	chomp;
	s/^([a-z]+(?:-[a-z]+)*)-(\d+)\[([a-z]{5})\]$/$1/ or die $_;
	my %letters;
	++$letters{$_} for split '';
	delete $letters{'-'};
	$sum += $2 unless $3 ne substr join('', sort {my $c = $letters{$b} <=> $letters{$a};return ($c != 0) ? $c : $a cmp $b} keys %letters), 0, 5;
}
close INPUT;

print "$sum\n";
