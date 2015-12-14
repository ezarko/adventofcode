#!/usr/bin/perl

use strict;
use warnings;

use integer;

use constant DURATION => 2503;
use List::Util qw(max sum);

my %reindeer;

open(INFILE, 'input.txt') or die "Cannot open file input.txt for reading: $!";
while (<INFILE>) {
    /^(\w+) can fly (\d+) km\/s for (\d+) seconds, but then must rest for (\d+) seconds\.\n$/ or die $_;
    my $c = DURATION / ($3 + $4);
    my $r = DURATION % ($3 + $4);
    $reindeer{$1} = ($c * $3 + ($r > $3 ? $3 : $r)) * $2;
}
close INFILE;

print max(values %reindeer) . "\n";
