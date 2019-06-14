#!/usr/bin/perl

use strict;
use warnings;

use List::Util qw(sum);

$_ = <>;
my @t = split;
my $t = parse_node(\@t);

printf "%d\n", sum collect_meta($t);

sub parse_node {
	my($t) = shift;
	my($c, $m) = splice @$t, 0, 2;

	my %node = (c=>[],m=>[]);
	push @{$node{c}}, parse_node($t) for 1..$c;
	push @{$node{m}}, splice @$t, 0, $m;

	return \%node;
}

sub collect_meta {
	my($node) = shift;

	my @meta = @{$node->{m}};
	push @meta, collect_meta($_) for @{$node->{c}};

	return @meta;
}
