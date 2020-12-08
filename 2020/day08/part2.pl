#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;
use File::Slurp;

chomp(my @lines = read_file('input.txt'));

my($a,$p,$t) = (0,0,0);
my %seen;
my %tried;

do {
  ++$seen{$p};
  if ($lines[$p] =~ /^nop ([+-]\d+)$/) {
    if ($t || $tried{$p}) {
      ++$p;
    } else {
      ++$tried{$p};
      $t = 1;
      $p += $1;
    }
  } elsif ($lines[$p] =~ /^acc ([+-]\d+)$/) {
    $a += $1;
    ++$p;
  } elsif ($lines[$p] =~ /^jmp ([+-]\d+)$/) {
    if ($t || $tried{$p}) {
      $p += $1;
    } else {
      ++$tried{$p};
      $t = 1;
      ++$p;
    }
  } else {
    die $_;
  }
  if ($p == @lines) {
    print "$a\n";
    exit;
  }
  if ($seen{$p}) {
    $a = $p = $t = 0;
    %seen = ();
  }
} while $p < @lines && !$seen{$p};
die Dumper $a, $p, $t, \%seen, \%tried;
