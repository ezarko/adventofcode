#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;
use File::Slurp;

chomp(my @lines = read_file('input.txt'));
my @backup = @lines;
my @set = splice @lines, 0, 25;
my $w;
check_next() while @lines;
my @e = find_elements();
printf "%d\n", $e[0] + $e[$#e];

sub check_next {
  for my $i (0..$#set) {
    for my $j (($i+1)..$#set) {
      next if $set[$i] == $set[$j];
      if ($lines[0] == $set[$i] + $set[$j]) {
        shift @set;
        push @set, shift @lines;
        return;
      }
    }
  }
  $w = $lines[0];
  @lines = ();
}

sub find_elements {
  for my $i (0..($#backup-1)) {
    my $j = $i + 1;
    my $t = $backup[$i] + $backup[$j];
    $t += $backup[++$j] while $t < $w && $j <= $#backup;
    return sort {$a <=> $b} splice @backup, $i, $j - $i + 1 if $t == $w;
  }
}
