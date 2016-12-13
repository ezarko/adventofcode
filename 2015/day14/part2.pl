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
    $reindeer{$1} = [0];
    for (my $t = 1; $t <= DURATION; ++$t) {
        my $r = $t % ($3 + $4);
        $reindeer{$1}[$t] = $reindeer{$1}[$t-1] + (($r > 0 && $r <= $3) ? $2 : 0);
    }
}
close INFILE;

for (my $t = 1; $t <= DURATION; ++$t) {
    my %set = map {($_ => $reindeer{$_}[$t])} keys %reindeer;
    my $max = max(values %set);
    $reindeer{$_}[$t] = ($set{$_} == $max) ? 1 : 0 for keys %reindeer;
}
$reindeer{$_} = sum(@{$reindeer{$_}}) for keys %reindeer;
print max(values %reindeer) . "\n";
