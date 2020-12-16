#!/usr/bin/perl

use strict;
use warnings;

open my $fh, 'input.txt';

my(@fields,@mine,@nearby);
while (<$fh>) {
  chomp;
  last if /^$/;
  /^([^:]+): (\d+)-(\d+) or (\d+)-(\d+)/ or die $_;
  push @fields, {L=>$1,V=>{map {($_ => 1)} $2..$3, $4..$5}};
}
die unless <$fh> eq "your ticket:\n";
chomp($_ = <$fh>);
@mine = split ',';
my $c = scalar @mine;
die unless <$fh> eq "\n";
die unless <$fh> eq "nearby tickets:\n";
@nearby = map {chomp;[split ',']} <$fh>;
die if grep {@$_ != $c} @nearby;

my %valid = map {($_ => 1)} map {keys %{$_->{V}}} @fields;
my @valid = map {my @c=@$_;{X=>{map {$_=>$c[$_]} 0..$#c}}} \@mine, grep {!scalar grep {!exists($valid{$_})} @$_} @nearby;
my %mine;
while (@fields) {
  my $field = shift @fields;
  my @p;
  for (my $i = 0; $i < $c; ++$i) {
    next unless exists $valid[0]{X}{$i};
    push @p, $i if @valid == grep {exists $field->{V}{$_}} map {$_->{X}{$i}} @valid;
  }
  die unless @p > 0;
  if (@p == 1) {
    #$fields{$p[0]} = $field->{L};
    $mine{$field->{L}} = $mine[$p[0]];
    delete $_->{X}{$p[0]} for @valid;
  } else {
    push @fields, $field;
  }
}
@mine = map {$mine{$_}} grep {/^departure /} keys %mine;
die unless @mine == 6;
printf "%d\n", $mine[0] * $mine[1] * $mine[2] * $mine[3] * $mine[4] * $mine[5];
