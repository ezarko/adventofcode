#!/bin/perl

use strict;
use warnings;

use MD5;

my $input = 'cxdnnyjw';

my($index,$pass) = (0,'');
while (length $pass < 8) {
	$pass .= $1 if MD5->hexhash($input . $index++) =~ /^00000(.)/;
}

print "$pass\n";
