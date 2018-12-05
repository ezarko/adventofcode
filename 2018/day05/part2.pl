#!/usr/bin/perl

use strict;
use warnings;

chomp(my $s = <>);
my %s;
for my $u (qw/a b c d e f g h i j k l m n o p q r s t u v w x y z/) {
	$_ = $s;
	s/$u//ig;
	printf "$u %d\n", length $_ while s/(aA|bB|cC|dD|eE|fF|gG|hH|iI|jJ|kK|lL|mM|nN|oO|pP|qQ|rR|sS|tT|uU|vV|wW|xX|yY|zZ|Aa|Bb|Cc|Dd|Ee|Ff|Gg|Hh|Ii|Jj|Kk|Ll|Mm|Nn|Oo|Pp|Qq|Rr|Ss|Tt|Uu|Vv|Ww|Xx|Yy|Zz)//;
	$s{$u} = length $_;
}
my($u) = sort {$s{$a} <=> $s{$b}} keys %s;
print "$s{$u}\n";
