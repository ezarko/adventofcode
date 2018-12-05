#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;
use List::Util qw(max);

chomp(my @l = sort <>);

my($g,%s);
for (@l) {
	if (/Guard #(\d+) begins shift/) {
		$g = $1;
		$s{$g} = {
			id => $g,
			m => [],
			t => 0,
		} unless exists $s{$g};
	} elsif (/00:(\d\d)\] falls asleep/) {
		push @{$s{$g}{m}}, [$1];
	} elsif (/00:(\d\d)\] wakes up/) {
		push @{$s{$g}{m}[-1]}, $1;
	} else {
		die "$_\n";
	}
}

for $g (keys %s) {
	my %m;
	for (@{$s{$g}{m}}) {
		die $_, $s{$_} unless scalar @$_ == 2;
		for (my $i = $_->[0]; $i < $_->[1]; ++$i) {
			++$m{sprintf "%02d", $i};
			++$s{$g}{t};
		}
	}
	$s{$g}{m} = \%m;
}
#die Dumper [map {($_ => $s{$_}{t})} sort {$s{$b}{t} <=> $s{$a}{t}} keys %s];
($g) = sort {$s{$b}{t} <=> $s{$a}{t}} keys %s;
my $m = max values %{$s{$g}{m}};
my @m = sort {$a <=> $b} grep {$s{$g}{m}{$_} == $m} keys %{$s{$g}{m}};
printf "%d\n", $g * $m[0];
