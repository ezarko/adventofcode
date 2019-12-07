#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;
use List::Util qw/sum/;

my %m;

while (<>) {
	/^([A-Z0-9]+)\)([A-Z0-9]+)\r?\n$/ or die $_;
	$m{$2} = $1;
}
my @y = ($m{YOU});
unshift @y, $m{$y[0]} while $y[0] ne 'COM';
my @s = ($m{SAN});
unshift @s, $m{$s[0]} while $s[0] ne 'COM';

while ($s[1] eq $y[1]) {
	shift @s;
	shift @y;
}

printf "%d\n", $#y + $#s;
