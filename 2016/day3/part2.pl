#!/bin/perl

use strict;
use warnings;

my $possible = 0;
my @data;

open INPUT, 'input.txt';
while(<INPUT>) {
	chomp;
	@_ = map {0 + $_} split;
	die unless @_ == 3;
	push @data, @_;
	if (@data == 9) {
		++$possible if ($data[0] + $data[3] > $data[6]) && ($data[0] + $data[6] > $data[3]) && ($data[3] + $data[6] > $data[0]);
		++$possible if ($data[1] + $data[4] > $data[7]) && ($data[1] + $data[7] > $data[4]) && ($data[4] + $data[7] > $data[1]);
		++$possible if ($data[2] + $data[5] > $data[8]) && ($data[2] + $data[8] > $data[5]) && ($data[5] + $data[8] > $data[2]);
		@data = ();
	}
}
close INPUT;
die "@data" if @data;

print "$possible\n";
