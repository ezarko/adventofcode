#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;
use List::Util qw(max);

my @p;
while (<>) {
	/^(\d+), (\d+)/ or die $_;
	push @p, [$1, $2];
}
my $mx = 1 + max map {$_->[0]} @p;
my $my = 1 + max map {$_->[1]} @p;
my @g;
for my $x (0..$mx) {
	for my $y (0..$my) {
		my @m = sort {$a->{d} <=> $b->{d}} map {{l => $_, d => abs($p[$_][0] - $x) + abs($p[$_][1] - $y)}} 0..$#p;
#print Dumper \@m;
		if ($m[0]{d} == $m[1]{d}) {
			$g[$x][$y] = -1;
		} else {
			$g[$x][$y] = $m[0]{l};
		}
	}
}
my %x;
map {++$x{$_}} @{$g[0]}, @{$g[-1]}, map {($_->[0], $_->[-1])} @g;
my %c;
for (map {@$_} @g) {
	++$c{$_};
}
my($a) = map {$_->{c}} sort {$b->{c} <=> $a->{c}} map {{i => $_, c => exists($x{$_}) ? 0 : $c{$_}}} 0..$#p;
print "$a\n";
