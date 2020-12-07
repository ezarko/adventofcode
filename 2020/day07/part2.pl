#!/usr/bin/perl

use strict;
use warnings;

use File::Slurp;
use List::Util qw(sum);

my %rules = map {
  die $_ unless /^(.*?) bags contain (.*)\.$/;
  my $key = $1;
  my %values;
  if ($2 ne 'no other bags') {
    %values = map {/^1 (.*) bag$/ ? ($1=>1) : /^(\d+) (.*) bags$/ ? ($2=>$1) : die $_} split ', ', $2;
  }
  ($key, \%values);
} read_file('input.txt');

my $count = count_of_contents('shiny gold');
print "$count\n";

sub count_of_contents {
  my $key = shift @_;

  return 0 unless %{$rules{$key}};
  return sum map {$rules{$key}{$_} + $rules{$key}{$_} * count_of_contents($_)} keys %{$rules{$key}};
}
