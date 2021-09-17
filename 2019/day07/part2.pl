#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;

$_ = <>;
chomp;
my @m = split ',';

my $m = 0;
for (possibilities(0..4)) {
	my($a) = intcomp(\@m, $_->[0], 0);
	my($b) = intcomp(\@m, $_->[1], $a);
	my($c) = intcomp(\@m, $_->[2], $b);
	my($d) = intcomp(\@m, $_->[3], $c);
	my($e) = intcomp(\@m, $_->[4], $d);
	$m = $e if $e > $m;
}
print "$m\n";

sub possibilities {
	return unless @_;
	return [$_[0]] if @_ == 1;
	return [$_[0], $_[1]], [$_[1], $_[0]] if @_ == 2;
	my @r = map [$_[0], @{$_}], possibilities(@_[1..$#_]);
	for (my $i = 1; $i < $#_; ++$i) {
		push @r, map [$_[$i], @{$_}], possibilities(@_[0..($i-1)], @_[($i+1)..$#_]);
	}
	push @r, map [$_[$#_], @{$_}], possibilities(@_[0..($#_-1)]);
	return @r;
}

sub intcomp {
	my @s = @{shift @_};
	my $p = 0;
	my @r;

	while ($s[$p] != 99) {
		if ($s[$p] == 1) {
			$s[$s[$p+3]] = $s[$s[$p+1]] + $s[$s[$p+2]];
			$p += 4;
		} elsif ($s[$p] == 2) {
			$s[$s[$p+3]] = $s[$s[$p+1]] * $s[$s[$p+2]];
			$p += 4;
		} elsif ($s[$p] == 3) {
			$s[$s[$p+1]] = shift @_;
			$p += 2;
		} elsif ($s[$p] == 4) {
			push @r, $s[$s[$p+1]];
			$p += 2;
		} elsif ($s[$p] == 5) {
			$p = $s[$s[$p+1]] ? $s[$s[$p+2]] : $p + 3;
		} elsif ($s[$p] == 6) {
			$p = $s[$s[$p+1]] ? $p + 3 : $s[$s[$p+2]];
		} elsif ($s[$p] == 7) {
			$s[$s[$p+3]] = $s[$s[$p+1]] < $s[$s[$p+2]] ? 1 : 0;
			$p += 4;
		} elsif ($s[$p] == 8) {
			$s[$s[$p+3]] = $s[$s[$p+1]] == $s[$s[$p+2]] ? 1 : 0;
			$p += 4;
		} elsif ($s[$p] == 101) {
			$s[$s[$p+3]] = $s[$p+1] + $s[$s[$p+2]];
			$p += 4;
		} elsif ($s[$p] == 102) {
			$s[$s[$p+3]] = $s[$p+1] * $s[$s[$p+2]];
			$p += 4;
		} elsif ($s[$p] == 104) {
			print "$s[$p+1]\n";
			$p += 2;
		} elsif ($s[$p] == 105) {
			$p = $s[$p+1] ? $s[$s[$p+2]] : $p + 3;
		} elsif ($s[$p] == 106) {
			$p = $s[$p+1] ? $p + 3 : $s[$s[$p+2]];
		} elsif ($s[$p] == 107) {
			$s[$s[$p+3]] = $s[$p+1] < $s[$s[$p+2]] ? 1 : 0;
			$p += 4;
		} elsif ($s[$p] == 108) {
			$s[$s[$p+3]] = $s[$p+1] == $s[$s[$p+2]] ? 1 : 0;
			$p += 4;
		} elsif ($s[$p] == 1001) {
			$s[$s[$p+3]] = $s[$s[$p+1]] + $s[$p+2];
			$p += 4;
		} elsif ($s[$p] == 1002) {
			$s[$s[$p+3]] = $s[$s[$p+1]] * $s[$p+2];
			$p += 4;
		} elsif ($s[$p] == 1005) {
			$p = $s[$s[$p+1]] ? $s[$p+2] : $p + 3;
		} elsif ($s[$p] == 1006) {
			$p = $s[$s[$p+1]] ? $p + 3 : $s[$p+2];
		} elsif ($s[$p] == 1007) {
			$s[$s[$p+3]] = $s[$s[$p+1]] < $s[$p+2] ? 1 : 0;
			$p += 4;
		} elsif ($s[$p] == 1008) {
			$s[$s[$p+3]] = $s[$s[$p+1]] == $s[$p+2] ? 1 : 0;
			$p += 4;
		} elsif ($s[$p] == 1101) {
			$s[$s[$p+3]] = $s[$p+1] + $s[$p+2];
			$p += 4;
		} elsif ($s[$p] == 1102) {
			$s[$s[$p+3]] = $s[$p+1] * $s[$p+2];
			$p += 4;
		} elsif ($s[$p] == 1105) {
			$p = $s[$p+1] ? $s[$p+2] : $p + 3;
		} elsif ($s[$p] == 1106) {
			$p = $s[$p+1] ? $p + 3 : $s[$p+2];
		} elsif ($s[$p] == 1107) {
			$s[$s[$p+3]] = $s[$p+1] < $s[$p+2] ? 1 : 0;
			$p += 4;
		} elsif ($s[$p] == 1108) {
			$s[$s[$p+3]] = $s[$p+1] == $s[$p+2] ? 1 : 0;
			$p += 4;
		} else {
			die Dumper @s, $p;
		}
	}

	return @r;
}
