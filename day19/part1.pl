#!/usr/bin/perl

use strict;
use warnings;

my %r;

open(INFILE, 'input.txt') or die "Cannot open file input.txt for reading: $!";
while (<INFILE>) {
  /^(.*?) => (.*?)\n$/ or last;
  push @{$r{$1}}, $2;
}
chomp(my $m = <INFILE>);
close INFILE;

my %o;
for my $r (keys %r) {
  my $p = -1;
  while (($p = index($m, $r, $p)) != -1) {
    my($b,$a) = (substr($m, 0, $p), substr($m, $p + length($r)));
    for (@{$r{$r}}) {
      ++$o{"$b$_$a"};
    }
    ++$p;
  }
}
print scalar(keys %o)."\n";
