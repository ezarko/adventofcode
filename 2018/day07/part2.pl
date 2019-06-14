#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;

my @e = map undef, 1..(1 + shift @ARGV);
my $c = shift @ARGV;
my %j;

while (<>) {
	/^Step ([A-Z]) must be finished before step ([A-Z]) can begin\./ or die $_;
	$j{$1} ||= {l=>$1,d=>{},w=>ord($1)-64+$c};
	$j{$2} ||= {l=>$2,d=>{},w=>ord($2)-64+$c};
	$j{$2}{d}{$1} = 1;
}

my $s = 0;
while (%j || scalar grep defined($_), @e) {
	for (0..$#e) {
		if (defined($e[$_])) {
			if (--$e[$_]{w} == 0) {
				my $n = $e[$_]{l};
				delete $j{$n};
				delete $j{$_}{d}{$n} for keys %j;
				$e[$_] = undef;
			}
		}
		$e[$_] = next_job() unless defined $e[$_];
	}
	$s++;
}
print --$s."\n";

sub next_job {
	my @a = sort {$a->{l} cmp $b->{l}} grep {!%{$_->{d}}} values %j;
	return @a ? delete $j{$a[0]{l}} : undef;
}
