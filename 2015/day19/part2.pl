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

my %c = ('e' => 0);
while (!exists $c{$m}) {
  my %n;
  while (my($k,$v) = each %c) {
    ++$v;
    for my $r (keys %r) {
      my $p = -1;
      while (($p = index($k, $r, $p)) != -1) {
        my($b,$a) = (substr($k, 0, $p), substr($k, $p + length($r)));
        for (@{$r{$r}}) {
          $_ = "$b$_$a";
          $n{$_} = $v unless $c{$_};
        }
        ++$p;
      }
    }
  }
  %c = %n;
}
print "$c{$m}\n";
