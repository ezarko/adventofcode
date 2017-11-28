#!/bin/perl

use strict;
use warnings;

open INPUT, 'input.txt';
while (<INPUT>) {
	chomp;
	s/^([a-z]+(?:-[a-z]+)*)-(\d+)\[([a-z]{5})\]$/$1/ or die $_;
	my $sector = $2;
	my %letters;
	++$letters{$_} for split '';
	delete $letters{'-'};
	next unless $3 eq substr join('', sort {my $c = $letters{$b} <=> $letters{$a};return ($c != 0) ? $c : $a cmp $b} keys %letters), 0, 5;
	eval join '', 'tr/-a-z/ ', map(chr((($_ + $sector) % 26) + ord('a')), 0..25), '/';
	print "$sector $_\n" if /north/ && /pole/;
}
close INPUT;
