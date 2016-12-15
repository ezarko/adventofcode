#!/bin/perl

use strict;
use warnings;

use MD5;

my $input = 'cxdnnyjw';

my $index = 0;
my @pass;
while (!defined $pass[0] || !defined $pass[1] || !defined $pass[2] || !defined $pass[3] || !defined $pass[4] || !defined $pass[5] || !defined $pass[6] || !defined $pass[7]) {
	$pass[$1] = $2 if MD5->hexhash($input . $index++) =~ /^00000([0-7])(.)/ && !defined $pass[$1];
}

$" = '';
print "@pass\n";
