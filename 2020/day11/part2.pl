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
  for my $y (0..$my) {
    for my $x (0..$mx) {
      $next[$y][$x] = check_seat($lines[$y][$x],
                                 fns($y, $x, -1, -1),
                                 fns($y, $x, -1,  0),
                                 fns($y, $x, -1,  1),
                                 fns($y, $x,  0, -1),
                                 fns($y, $x,  0,  1),
                                 fns($y, $x,  1, -1),
                                 fns($y, $x,  1,  0),
                                 fns($y, $x,  1,  1),
                                );
    }
  }
  $prev = join "\n", map join('', @$_), @lines;
  @lines = @next;
  $next = join "\n", map join('', @$_), @lines;
} while($next ne $prev);

printf "%d\n", scalar grep /#/, map @$_, @lines;

sub check_seat {
  my($v,@a) = @_;
  ($v eq 'L' && ! grep /#/, @a) ? '#' : ($v eq '#' && 4 < grep /#/, @a) ? 'L' : $v;
}

sub fns { # find next seat
  my($y, $x, $dy, $dx) = @_;
  do {
    $y += $dy;
    $x += $dx;
    return '.' if $y < 0 || $y > $my || $x < 0 || $x > $mx;
  } while ($lines[$y][$x] eq '.');
  $lines[$y][$x];
}
