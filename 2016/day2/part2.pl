#!/bin/perl

use strict;
use warnings;

my $k = 5;
my %move = (
	U => sub{if($k==3){$k=1}elsif($k=~/^([678]|1[012])$/){$k-=4}elsif($k==13){$k=11}},
	R => sub{++$k if $k=~/^([235678]|1[01])$/},
	D => sub{if($k==1){$k=3}elsif($k=~/^[234678]$/){$k+=4}elsif($k==11){$k=13}},
	L => sub{--$k if $k =~ /^([346789]|1[12])$/},
);
my $r = '';

open INPUT, "input.txt";
while (<INPUT>) {
	chomp;
	die unless /^[URDL]*$/;
	
	$move{$_}() for split '';
	$r .= ($k == 13) ? 'D' : ($k == 12) ? 'C' : ($k == 11) ? 'B' : ($k == 10) ? 'A' : $k;
}
close INPUT;

print "$r\n";
