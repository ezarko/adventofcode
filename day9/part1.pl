#!/usr/bin/perl

use strict;
use warnings;

my %map;

open(INFILE, 'input.txt') or die "Cannot open file input.txt for reading: $!";
while (<INFILE>) {
    /(\w*) to (\w*) = (\d+)\n/ or die $_;
    $map{$1}{$2} = $map{$2}{$1} = 0 + $3;
}
close INFILE;
$map{$_}{$_} = 65535 for keys %map;

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

my $s = 65535;
for (alternates(keys %map)) {
    my $d = $map{$_->[0]}{$_->[1]} + $map{$_->[1]}{$_->[2]} + $map{$_->[2]}{$_->[3]} + $map{$_->[3]}{$_->[4]} + $map{$_->[4]}{$_->[5]} + $map{$_->[5]}{$_->[6]} + $map{$_->[6]}{$_->[7]};
    $s = $d if $d < $s;
}
print "$s\n";
