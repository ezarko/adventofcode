#!/usr/bin/perl

use strict;
use warnings;

use File::Slurp;

chomp(my @lines = read_file('input.txt'));
@lines = map {[split '']} @lines;

my $prev;
my $next;
my $my = $#lines;
my $mx = $#{$lines[0]};
do {
  my @next;
  # corners
  $next[0][0] = ($lines[0][0] eq 'L') ? '#' : $lines[0][0];
  $next[0][$mx] = ($lines[0][$mx] eq 'L') ? '#' : $lines[0][$mx];
  $next[$my][0] = ($lines[$my][0] eq 'L') ? '#' : $lines[$my][0];
  $next[$my][$mx] = ($lines[$my][$mx] eq 'L') ? '#' : $lines[$my][$mx];
  # edges
  for my $x (1..($mx-1)) {
    $next[0][$x] = check_seat($lines[0][$x], $lines[0][$x-1], $lines[0][$x+1], @{$lines[1]}[($x-1)..($x+1)]);
    $next[$my][$x] = check_seat($lines[$my][$x], $lines[$my][$x-1], $lines[$my][$x+1], @{$lines[$my-1]}[($x-1)..($x+1)]);
  }
  for my $y (1..($my-1)) {
    $next[$y][0] = check_seat($lines[$y][0], @{$lines[$y-1]}[0..1], $lines[$y][1], @{$lines[$y+1]}[0..1]);
    $next[$y][$mx] = check_seat($lines[$y][$mx], @{$lines[$y-1]}[($mx-1)..$mx], $lines[$y][$mx-1], @{$lines[$y+1]}[($mx-1)..$mx]);
  }
  # center
  for my $y (1..($my-1)) {
    for my $x (1..($mx-1)) {
      $next[$y][$x] = check_seat($lines[$y][$x], @{$lines[$y-1]}[($x-1)..($x+1)], $lines[$y][$x-1], $lines[$y][$x+1], @{$lines[$y+1]}[($x-1)..($x+1)]);
    }
  }
  $prev = join "\n", map join('', @$_), @lines;
  @lines = @next;
  $next = join "\n", map join('', @$_), @lines;
} while($next ne $prev);

printf "%d\n", scalar grep /#/, map @$_, @lines;

sub check_seat {
  my($v,@a) = @_;
  ($v eq 'L' && ! grep /#/, @a) ? '#' : ($v eq '#' && 3 < grep /#/, @a) ? 'L' : $v;
}
