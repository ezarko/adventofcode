#!/bin/perl

use strict;
use warnings;

my $k = 5;
my %move = (
	U => sub{$k -= 3 if $k > 3},
	R => sub{++$k if $k % 3},
	D => sub{$k += 3 if $k < 7},
	L => sub{--$k unless 1 == ($k % 3)},
);
my $r = '';

open INPUT, "input.txt";
while (<INPUT>) {
	chomp;
	die unless /^[URDL]*$/;
	
	$move{$_}() for split '';
	$r .= $k;
}
close INPUT;

print "$r\n";
