#!/usr/bin/perl

use strict;
use warnings;

use List::Util qw(sum);

$_ = <>;
my @t = split;

printf "%d\n", parse_node(\@t);

sub parse_node {
	my($t) = shift;
	my($c, $m) = splice @$t, 0, 2;

	my @c = map parse_node($t), 1..$c;
	my @m = splice @$t, 0, $m;

	return sum($c ? map(($_==0||$_>$c)?0:$c[$_-1], @m) : @m);
}
