#!/usr/bin/perl

use strict;

use JSON;

open(INFILE, 'input.txt') or die "Cannot open file input.txt for reading: $!";
my $d = decode_json scalar <INFILE> or die;
close INFILE;

print sum($d) . "\n";

sub sum {
  my $t;
  if (ref($_[0]) eq '') {
    $t += 0 + $_[0];
  } elsif (ref($_[0]) eq 'ARRAY') {
    $t += sum($_) for @{$_[0]};
  } elsif (ref($_[0]) eq 'HASH') {
    $t += sum($_) for values %{$_[0]};
  } else {
    die;
  }
  return $t;
}
