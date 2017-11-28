#!/bin/perl

use strict;
use warnings;

my($rows,$cols) = (6,50);
my @display = (split '', '0' x ($rows*$cols));

open INPUT, 'input.txt';
while (<INPUT>) {
	chomp;
	if (/^rect (\d+)x(\d+)$/) {
		for (my $x = 0; $x < $1; ++$x) {
			for (my $y = 0; $y < $2; ++$y) {
				$display[$x+$y*$cols] = '1';
			}
		}
	} elsif (/^rotate row y=(\d+) by (\d+)$/) {
		my @row = @display[($1*$cols)..($1*$cols+$cols-1)];
		unshift @row, splice @row, $cols - $2 % $cols;
		splice @display, $1 * $cols, $cols, @row;
	} elsif (/^rotate column x=(\d+) by (\d+)$/) {
		my @i = ($1);
		push @i, $i[$#i] + $cols while $i[$#i] + $cols < @display;
		my @col = @display[@i];
		unshift @col, splice @col, $rows - $2 % $rows;
		@display[@i] = @col;
	} else {
		die $_;
	}
}
close INPUT;

@display = grep {$_} @display;

print scalar(@display)."\n";
