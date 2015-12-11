#!/usr/bin/perl

use strict;
use warnings;

use constant INPUT => 'cqjxjnds';

sub nextpw {
  die $_[0] unless $_[0] =~ /^[a-z]{8}$/;
  @_ = map ord($_), split '', shift;

  do {
    ++$_[7];
    for (my $i = 7; $i > 0; --$i) {
      if ($_[$i] == 123) {
        ++$_[$i-1];
        $_[$i] = 97;
      }
    }
    die if $_[0] == 123;
  } while !meetsrequirements(join '', map chr($_), @_);

  return join '', map chr($_), @_;
}
sub meetsrequirements {
  local $_ = shift;
  return if /[ilo]/;
  return unless /(abc|bcd|cde|def|efg|fgh|pqr|qrs|rst|stu|tuv|uvw|vwx|wxy|xyz)/ && (s/([a-z])\1//g == 2);
  return 1;
}

print nextpw(INPUT)."\n";
