#!/usr/bin/perl

use strict;
use warnings;

my @c;

open(INFILE, 'input.txt') or die "Cannot open file input.txt for reading: $!";
while (<INFILE>) {
    push @c, 0 + $_;
}
close INFILE;

@c = sort {$b <=> $a} @c;

sub alternates {
  my @a;
  my $t = shift;
  return unless $t > 0;
  while (@_) {
    shift while $_[0] > $t;
    return () unless @_;
    if ($_[0] == $t) {
      push @a, [shift] while @_ && $_[0] == $t;
    } else {
      my $x = shift;
      push @a, map {unshift @$_, $x;$_} alternates($t-$x, @_);
    }
  }
  return @a;
}

my @a = alternates(150, @c);
my $l = [sort {$a<=>$b} map {scalar @$_} @a]->[0];
@a = grep {scalar(@$_) == $l} @a;
print @a."\n";
