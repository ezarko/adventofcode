#!/bin/perl

use strict;
use warnings;

my($x,$y,$d) = (0, 0, 0);

my @directions = (
	sub {my $i = shift;for(1..$i){++$y;visit()}},
	sub {my $i = shift;for(1..$i){++$x;visit()}},
	sub {my $i = shift;for(1..$i){--$y;visit()}},
	sub {my $i = shift;for(1..$i){--$x;visit()}},
);
my %visited = (0 => {0 => 1});
sub visit {
	if ($visited{$x}{$y}) {
		printf "%d\n", abs($x)+ abs($y);
		exit;
	}
	$visited{$x}{$y} = 1;
}

$/ = undef;
open INPUT, "input.txt";
$_ = <INPUT>;
close INPUT;
s/\s*\r?\n$//;
for (split /,\s*/) {
	s/^([RL])(\d+)$// or die $_;
	$d += ($1 eq 'R') ? 1 : -1;
	$d -= 4 if $d > 3;
	$d += 4 if $d < 0;
	$directions[$d]->($2);
}
