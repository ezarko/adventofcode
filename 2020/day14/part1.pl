#!/usr/bin/perl

use strict;
use warnings;

use File::Slurp;
use List::Util qw(sum);

chomp(my @lines = read_file('input.txt'));

my(%mask,@mem);

for (@lines) {
  if (/^mask = ([01X]{36})$/) {
    my @mask = split '', $1;
    %mask = ();
    for (0..35) {
      $mask{$_} = $mask[$_] unless $mask[$_] eq 'X';
    }
  } elsif (/^mem\[(\d+)\] = (\d+)$/) {
    my $v = unpack("B64", pack "Q>", $2);
    vec($v, $_ + 28, 8) = ord($mask{$_}) for keys %mask;
    $mem[$1] = unpack("Q>", pack "B64", $v);
  } else {
    die "$_\n";
  }
}
print sum(@mem) . "\n";
