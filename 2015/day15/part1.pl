#!/usr/bin/perl

use strict;
use warnings;

use integer;

my @i;

open(INFILE, 'input.txt') or die "Cannot open file input.txt for reading: $!";
while(<INFILE>) {
  /^([^:]+): capacity (-?\d+), durability (-?\d+), flavor (-?\d+), texture (-?\d+), calories (-?\d+)\n/ or die $_;
  push @i, {
    name       => $1,
    capacity   => 0 + $2,
    durability => 0 + $3,
    flavor     => 0 + $4,
    texture    => 0 + $5,
    calories   => 0 + $6,
    count      => 0,
  };
}
close INFILE;

my $best = 0;
$i[$#i]{count} = 100;
while ($i[0]{count} < 100) {
  check(@i);
  my $p = $#i;
  if ($i[$p]{count} > 0) {
    --$i[$p]{count};
    ++$i[--$p]{count};
  } else {
    --$p until $i[$p]{count};
    ++$i[$p-1]{count};
    $i[$#i]{count} = $i[$p]{count} - 1;
    $i[$p]{count} = 0;
  }
}
check(@i);
print "$best\n";

sub check {
  my($c, $d, $f, $t);
  for (@_) {
    $c += $_->{count} * $_->{capacity};
    $d += $_->{count} * $_->{durability};
    $f += $_->{count} * $_->{flavor};
    $t += $_->{count} * $_->{texture};
  }
  return if $c < 1 || $d < 1 || $f < 1 || $t < 1;
  my $score = $c * $d * $f * $t;
  $best = $score if $score > $best;
}
