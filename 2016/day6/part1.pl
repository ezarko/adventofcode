#!/bin/perl

use strict;
use warnings;

open INPUT, 'input.txt';
my @messages = <INPUT>;
close INPUT;
chomp @messages;

my $message = '';
while (length $messages[0]) {
  my %characters;
  $characters{$_}++ for map {$messages[$_]=~s/^(.)//;$1} 0..$#messages;
  $message .= [sort {$characters{$b} <=> $characters{$a}} keys %characters]->[0];
}

print "$message\n";
