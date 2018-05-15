#!/usr/bin/perl

use strict;
use warnings;

$_ = <>;
chomp;

die $_ unless $_ && ("$_" eq ($_+0)) && ($_ > 0);
print "$_\n";

if ($_ == 1) {
	print "0\n";
	exit;
}

my $i = 1;
$i += 1 while int($_/((1+2*$i)**2)) > 0;
print "$i\n";
