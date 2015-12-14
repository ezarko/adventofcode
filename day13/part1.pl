#!/usr/bin/perl

use strict;
use warnings;

my %map;

open(INFILE, 'input.txt') or die "Cannot open file input.txt for reading: $!";
while (<INFILE>) {
    /^(\w+) would (gain|lose) (\d+) happiness units by sitting next to (\w+)\.\n$/ or die $_;
    $map{$1}{$4} = ($2 eq 'gain' ? 1 : -1) * $3;
}
close INFILE;

sub alternates {
    my @a;
    if (@_ == 2) {
        @a = ([@_], [$_[1],$_[0]]);
    } else {
        @a = (map {[$_[0],@$_]} alternates(@_[1..$#_]));
        for my $i (1..($#_-1)) {
            push @a, map {[$_[$i],@$_]} alternates(@_[0..($i-1)],@_[($i+1)..$#_]);
        }
        push @a, map {[$_[$#_],@$_]} alternates(@_[0..($#_-1)]);
    }
    return @a;
}

my $t = 0;
for (alternates(keys %map)) {
    my @s = @$_;
    my $d = $map{$s[$#s]}{$s[0]} + $map{$s[0]}{$s[$#s]};
    $d += $map{$s[$_-1]}{$s[$_]} + $map{$s[$_]}{$s[$_-1]} for 1..$#s;
    $t = $d if $d > $t;
}
print "$t\n";
