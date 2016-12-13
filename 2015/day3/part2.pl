#!/usr/bin/perl

use strict;
use warnings;

open(INFILE, 'input.txt') or die "Cannot open file input.txt for reading: $!";
$_ = <INFILE>;
close INFILE;

my($x,$y,$x1,$y1,$p)=(0,0,0,0,0);
my %h = (0 => {0 => 2});
for (split '') {
  if (++$p % 2) {
    ($_ eq '>' ? ++$x  :
     $_ eq '<' ? --$x  :
     $_ eq '^' ? ++$y  :
     $_ eq 'v' ? --$y  :
                 die $_
    );
  } else {
    ($_ eq '>' ? ++$x1 :
     $_ eq '<' ? --$x1 :
     $_ eq '^' ? ++$y1 :
     $_ eq 'v' ? --$y1 :
                 die $_
    );
  }
  ++$h{$x}{$y};
  ++$h{$x1}{$y1};
}
my $t = scalar map {values %$_} values %h;
print "$t\n";
