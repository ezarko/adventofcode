#!/usr/bin/perl

use strict;
use warnings;

$_ = <>;
chomp;
@_ = split '';
my $m = @_/2;
my $s = 0;
for (0..$#_) {
	$s += $_[$_] if $_[($_+$m)%@_] == $_[$_];
}
print "$s\n";
