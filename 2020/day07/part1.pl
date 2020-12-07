#!/usr/bin/perl

use strict;
use warnings;

use File::Slurp;

my %rules = map {
  die $_ unless /^(.*?) bags contain (.*)\.$/;
  my $key = $1;
  my @values;
  if ($2 ne 'no other bags') {
    @values = map {s/^1 (.*) bag$/$1/ || s/^\d+ (.*) bags$/$1/ || die $_;$_} split ', ', $2;
  }
  ($key, \@values);
} read_file('input.txt');

my $count = 0;
for (grep {$_ ne 'shiny gold'} keys %rules) {
  ++$count if can_hold_shiny_gold($_);
}

print "$count\n";

sub can_hold_shiny_gold {
  my $key = shift @_;

  return 1 if grep {$_ eq 'shiny gold' || can_hold_shiny_gold($_)} @{$rules{$key}};
}
