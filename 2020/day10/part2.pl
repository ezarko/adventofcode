#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;
use File::Slurp;
use List::Util qw(sum);

chomp(my @lines = read_file('input.txt'));
@lines = sort {$a <=> $b} @lines;
unshift @lines, 0;
push @lines, $lines[$#lines] + 3;

my @p;
$p[$#lines] = 1;
for (my $i = $#lines - 1; $i >= 0; --$i) {
  $p[$i] = sum(map {$p[$_]} grep {$lines[$_] > $lines[$i] && $lines[$_] <= $lines[$i] + 3} 0..$#lines);
}
print "$p[0]\n";
