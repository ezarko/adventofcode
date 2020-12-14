#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;
use File::Slurp;
use List::Util qw(sum);

#my @lines = ("mask = 000000000000000000000000000000X1001X","mem[42] = 100","mask = 00000000000000000000000000000000X0XX","mem[26] = 1");
chomp(my @lines = read_file('input.txt'));

my(%mask,%mem);

for (@lines) {
  if (/^mask = ([01X]{36})$/) {
    my @mask = split '', $1;
    %mask = ();
    for (0..35) {
      $mask{$_} = $mask[$_] unless $mask[$_] eq '0';
    }
  } elsif (/^mem\[(\d+)\] = (\d+)$/) {
    my $v = unpack("B64", pack "Q>", $1);
    vec($v, $_ + 28, 8) = ord($mask{$_}) for keys %mask;
    my @p = ($v);
    while ($p[0] =~ /X/) {
      @p = map {
        my $a = $_;
        $a =~ s/X/0/;
        s/X/1/;
        ($a, $_)
      } @p;
    }
    $mem{unpack("Q>", pack "B64", $_)} = $2 for @p;
  } else {
    die "$_\n";
  }
}
print sum(values %mem) . "\n";
