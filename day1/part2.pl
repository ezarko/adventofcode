#!/usr/bin/perl

use strict;
use warnings;

open(INFILE, 'input.txt') or die "Cannot open file input.txt for reading: $!";
$_ = <INFILE>;
close INFILE;

my($f,$p);
for (split '', $_) {
  ++$p;
  ($_ eq '(' ? ++$f  :
   $_ eq ')' ? --$f  :
               die $_
  );
  die "$p\n" if $f < 0;
}
