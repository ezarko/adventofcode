#!/bin/perl

use strict;
use warnings;

use Data::Dumper;

my $item = 'a (\w+)( generator|-compatible microchip)';
my %floors = (
  F1 => [],
  F2 => [],
  F3 => [],
  F4 => [],
);
my $e = 1;
my %map = (
  first  => 'F1',
  second => 'F2',
  third  => 'F3',
  fourth => 'F4',
  ' generator' => 'G',
  '-compatible microchip' => 'M',
  'hydrogen' => 'H',
  'lithium' => 'L',
);

open INPUT, 'input.txt';
while (<INPUT>) {
	chomp;
	s/^The (first|second|third|fourth) floor contains ((nothing relevant)|$item|(?:$item, )*$item and $item).$/$2/ or die $_;
	my $floor = $map{$1};
	if ($3) {
	} elsif ($4) {
		push @{$floors{$floor}}, "$map{$4}$map{$5}";
	} else {
		while (s/^$item(, | and |$)//) {
			push @{$floors{$floor}}, "$map{$1}$map{$2}";
		}
	}
}
close INPUT;

for (qw/F4 F3 F2 F1/) {
	printf "%s %s %s %s %s %s\n", $_,
	(($_ eq "F$e") ? 'E ' : '. '),
	((grep {$_ eq 'HG'} @{$floors{$_}}) ? 'HG' : '. '),
	((grep {$_ eq 'HM'} @{$floors{$_}}) ? 'HM' : '. '),
	((grep {$_ eq 'LG'} @{$floors{$_}}) ? 'LG' : '. '),
	((grep {$_ eq 'LM'} @{$floors{$_}}) ? 'LM' : '. ');
}

# now, move 1 or 2 items (G or M) one floor at a time
# M can only be in elevator or on floor with matching G
