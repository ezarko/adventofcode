#!/usr/bin/perl

use strict;
use warnings;

my %v;

open(INFILE, 'input.txt') or die "Cannot open file input.txt for reading: $!";
@_ = <INFILE>;
close INFILE;

while(@_) {
  $_ = shift @_;
  if (/^(\d+) -> ([a-z]+)\n$/) {
    $v{$2} = $1;
  } elsif (/^([a-z]+) -> ([a-z]+)\n$/ && exists $v{$1}) {
    $v{$2} = $v{$1};
  } elsif (/^(\d+) AND ([a-z]+) -> ([a-z]+)\n$/ && exists $v{$2}) {
    $v{$3} = $1 & $v{$2};
  } elsif (/^([a-z]+) AND ([a-z]+) -> ([a-z]+)\n$/ && exists $v{$1} && exists $v{$2}) {
    $v{$3} = ($v{$1}+0) & ($v{$2}+0);
  } elsif (/^([a-z]+) OR ([a-z]+) -> ([a-z]+)\n$/ && exists $v{$1} && exists $v{$2}) {
    $v{$3} = $v{$1} | $v{$2};
  } elsif (/^([a-z]+) LSHIFT (\d+) -> ([a-z]+)\n$/ && exists $v{$1}) {
    $v{$3} = 65535 & ($v{$1} << $2);
  } elsif (/^([a-z]+) RSHIFT (\d+) -> ([a-z]+)\n$/ && exists $v{$1}) {
    $v{$3} = $v{$1} >> $2;
  } elsif (/^NOT ([a-z]+) -> ([a-z]+)\n$/ && exists $v{$1}) {
    $v{$2} = 65535 & ~ $v{$1};
  } else {
    push @_, $_;
  }
}

print "$v{a}\n";
