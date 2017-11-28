#!/bin/perl

use strict;
use warnings;

use Data::Dumper;

my @bots;
my @outputs;
sub give {
	my($bot, $value) = @_;
	$bots[$bot]{inputs} ||= [];
	push @{$bots[$bot]{inputs}}, $value;
}

open INPUT, 'input.txt';
while (<INPUT>) {
	if (/^value (\d+) goes to bot (\d+)$/) {
		give($2, $1);
	} elsif (/^bot (\d+) gives low to (bot|output) (\d+) and high to (bot|output) (\d+)$/) {
		$bots[$1]{outputs}{low}{$2}  = $3;
		$bots[$1]{outputs}{high}{$4} = $5;
	} else {
		die $_;
	}
}
close INPUT;

for (@bots) {
	$_->{inputs} ||= [];
	$_->{done} = undef;
}

while (grep {!$_->{done}} @bots) {
	for (grep {!$_->{done}} @bots) {
		next unless @{$_->{inputs}} == 2;
		my($low,$high) = (sort {$a <=> $b} @{$_->{inputs}});
		give($_->{outputs}{low}{bot}, $low) if exists $_->{outputs}{low}{bot};
		give($_->{outputs}{high}{bot}, $high) if exists $_->{outputs}{high}{bot};
		$outputs[$_->{outputs}{low}{output}] = $low if exists $_->{outputs}{low}{output};
		$outputs[$_->{outputs}{high}{output}] = $high if exists $_->{outputs}{high}{output};
		$_->{done} = 1;
	}
}

print $outputs[0] * $outputs[1] * $outputs[2];
