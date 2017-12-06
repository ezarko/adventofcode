#!/usr/bin/perl

use strict;
use warnings;

$_ = <>;
chomp;
@_ = split '';
my $s = 0;
for (0..($#_-1)) {
	$s += $_[$_] if $_[$_+1] == $_[$_];
}
$s += $_[0] if $_[0] == $_[$#_];
print "$s\n";
