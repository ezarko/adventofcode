#!/usr/bin/perl

use strict;
use warnings;

use constant INPUT => '1113122113';

sub las {
    my @r;
    while (@_) {
        my $n = shift;
        my $c = 1;
        while (@_ && $_[0] == $n) {
            shift;
            ++$c;
        }
        push @r, $c, $n;
    }
    return @r;
}

my @i = split '', INPUT;
@i = las(@i) for 1..40;
print scalar(@i) . "\n";
