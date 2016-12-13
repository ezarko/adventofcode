#!/usr/bin/perl

use strict;
use warnings;

open(INFILE, 'input.txt') or die "Cannot open file input.txt for reading: $!";
chomp(@_ = <INFILE>);
close INFILE;

my %boss;
$_[0] =~ /^Hit Points: (\d+)$/ or die;
$boss{hp} = $1;
$_[1] =~ /^Damage: (\d+)$/ or die;
$boss{damage} = $1;
$_[2] =~ /^Armor: (\d+)$/ or die;
$boss{armor} = $1;

my @weapons = (
  {
    name   => 'Dagger',
    cost   => 8,
    damage => 4,
    armor  => 0,
  },
  {
    name   => 'Shortsword',
    cost   => 10,
    damage => 5,
    armor  => 0,
  },
  {
    name   => 'Warhammer',
    cost   => 25,
    damage => 6,
    armor  => 0,
  },
  {
    name   => 'Longsword',
    cost   => 40,
    damage => 7,
    armor  => 0,
  },
  {
    name   => 'Greataxe',
    cost   => 74,
    damage => 8,
    armor  => 0,
  },
);

my @armor = (
  {
    name   => 'Leather',
    cost   => 13,
    damage => 0,
    armor  => 1,
  },
  {
    name   => 'Chainmail',
    cost   => 31,
    damage => 0,
    armor  => 2,
  },
  {
    name   => 'Splintmail',
    cost   => 53,
    damage => 0,
    armor  => 3,
  },
  {
    name   => 'Bandedmail',
    cost   => 75,
    damage => 0,
    armor  => 4,
  },
  {
    name   => 'Platemail',
    cost   => 102,
    damage => 0,
    armor  => 5,
  },
);

my @rings = (
  {
    name   => 'Damage +1',
    cost   => 25,
    damage => 1,
    armor  => 0,
  },
  {
    name   => 'Damage +2',
    cost   => 50,
    damage => 2,
    armor  => 0,
  },
  {
    name   => 'Damage +3',
    cost   => 100,
    damage => 3,
    armor  => 0,
  },
  {
    name   => 'Defense +1',
    cost   => 20,
    damage => 0,
    armor  => 1,
  },
  {
    name   => 'Defense +2',
    cost   => 40,
    damage => 0,
    armor  => 2,
  },
  {
    name   => 'Defense +3',
    cost   => 80,
    damage => 0,
    armor  => 3,
  },
);

my @alternatives;
for my $w (@weapons) {
  push @alternatives, [$w]; # no armor or rings
  for my $a (@armor) {
    push @alternatives, [$w, $a]; # armor, no rings
    for my $r1 (@rings) {
      push @alternatives, [$w, $r1]; # no armor, one ring
      push @alternatives, [$w, $a, $r1]; # armor, one ring
      for my $r2 (@rings) {
        next if $r1->{name} eq $r2->{name}; # only one of each type
        push @alternatives, [$w, $r1, $r2]; # no armor, two rings
        push @alternatives, [$w, $a, $r1, $r2]; # full kit
      }
    }
  }
}
my $least_cost = 65535;
for (@alternatives) {
  my $shp = 100;
  my $bhp = $boss{hp};

  my $sd = - $boss{armor};
  my $bd = $boss{damage};
  my $cost = 0;
  for (@$_) {
    $sd += $_->{damage};
    $bd -= $_->{armor};
    $cost += $_->{cost};
  }
  $sd = 1 if $sd < 1;
  $bd = 1 if $bd < 1;

  while ($shp > 0 && $bhp > 0) {
    $bhp -= $sd;
    last if $bhp <= 0;
    $shp -= $bd;
  }
  if ($shp > 0) { # win
    $least_cost = $cost if $cost < $least_cost;
  }
}
print "$least_cost\n";
