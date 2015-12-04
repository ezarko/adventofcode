#!/usr/bin/perl

use strict;
use warnings;

open(INFILE, 'input.txt') or die "Cannot open file input.txt for reading: $!";
$_ = <INFILE>;
close INFILE;

my($x,$y)=(0,0);
my %h = (0 => {0 => 1});
for (split '') {
  ($_ eq '>' ? ++$x  :
   $_ eq '<' ? --$x  :
   $_ eq '^' ? ++$y  :
   $_ eq 'v' ? --$y  :
               die $_
  );
  ++$h{$x}{$y};
}
my $t = scalar map {values %$_} values %h;
print "$t\n";
