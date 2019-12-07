#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;
use List::Util qw/sum/;

my %m;

while (<>) {
	/^([A-Z0-9]+)\)([A-Z0-9]+)\r?\n$/ or die $_;
	#$m{$1} ||= [];
	push @{$m{$1}}, $2;
}

my %t;
count(1, @{$m{COM}});

printf "%d\n", sum values %t;

sub count {
	my $o = shift @_;
	for (@_) {
		$t{$_} = $o;
		count($o+1, @{$m{$_}}) if exists $m{$_};
	}
}
