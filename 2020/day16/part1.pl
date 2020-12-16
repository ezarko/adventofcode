#!/usr/bin/perl

use strict;
use warnings;

use List::Util qw(sum);

open my $fh, 'input.txt';

my(%fields,@mine,@nearby);
while (<$fh>) {
  chomp;
  last if /^$/;
  /^([^:]+): (\d+)-(\d+) or (\d+)-(\d+)/ or die $_;
  $fields{$1} = [$2..$3, $4..$5];
}
die unless <$fh> eq "your ticket:\n";
chomp($_ = <$fh>);
@mine = split ',';
die unless <$fh> eq "\n";
die unless <$fh> eq "nearby tickets:\n";
@nearby = map {chomp;[split ',']} <$fh>;

my %valid = map {($_ => 1)} map {(@$_)} values %fields;
printf "%d\n", sum grep {!exists($valid{$_})} map {(@$_)} @nearby;
