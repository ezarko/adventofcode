#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;

open(INFILE, 'input.txt') or die "Cannot open file input.txt for reading: $!";
chomp(@_ = <INFILE>);
close INFILE;

my %boss;
$_[0] =~ /^Hit Points: (\d+)$/ or die;
$boss{hp} = $1;
$_[1] =~ /^Damage: (\d+)$/ or die;
$boss{damage} = $1;

my %self = (
  hp => 50,
  armor => 0,
  mana => 500,
  effects => [],
);

%boss = (hp=>14,damage=>8);%self = (hp=>10,armor=>0,mana=>250);
my @spells = (
  'Magic Missile',
  'Drain',
  'Shield',
  'Poison',
  'Recharge',
);

my $least = 65535;
sub take_turns {
  my($shp, $mana, $bhp, $damage, $total, $stack, %effects) = @_;
  return if $shp < 1 || $mana < 0 || $total > $least;
  my @stack = @$stack;
  my $d = $damage;

  if (defined $effects{shield}) {
    $d -= 7;
    $d = 1 if $d < 1;
    --$effects{shield};
    delete $effects{shield} unless $effects{shield};
  }

  if (defined $effects{poison}) {
    $bhp -= 3;
    if ($bhp < 1) {
      $least = $total if $total < $least;
      return [$total, @stack, 0];
    }
    --$effects{poison};
    delete $effects{poison} unless $effects{poison};
  }

  if (defined $effects{recharge}) {
    $mana += 101;
    --$effects{recharge};
    delete $effects{recharge} unless $effects{recharge};
  }

  my @results;
  if ($mana >= 53) {
    if ($bhp <= 4) {
      $least = $total + 53 if $total + 53 < $least;
      push @results, [$total + 53, @stack, 0];
    } elsif ($shp - $d > 0) {
      push @results, take_turns($shp - $d, $mana - 53, $bhp - 4, $damage, $total + 53, [@stack, 0], %effects);
    }
  }
  if ($mana >= 73) {
    if ($bhp <= 2) {
      $least = $total + 73 if $total + 73 < $least;
      push @results, [$total + 73, @stack, 1];
    } elsif ($shp + 2 - $d > 0) {
      push @results, take_turns($shp + 2 - $d, $mana - 73, $bhp - 2, $damage, $total + 73, [@stack, 1], %effects);
    }
  }
  if ($shp - $d > 0) {
    if ($mana >= 113 && !defined $effects{shield}) {
      $d = $damage - 7;
      $d = 1 if $d < 1;
      push @results, take_turns($shp - $d, $mana - 113, $bhp, $damage, $total + 113, [@stack, 2], %effects, shield => 5);
    }
    if ($mana >= 173 && !defined $effects{poison}) {
      $bhp -= 3;
      if ($bhp < 1) {
        $total += 173;
        $least = $total if $total < $least;
        return [$total, @stack, 3];
      }
      push @results, take_turns($shp - $d, $mana - 173, $bhp, $damage, $total + 173, [@stack, 3], %effects, poison => 5);
    }
    if ($mana >= 229 && !defined $effects{recharge}) {
      $mana += 101;
      push @results, take_turns($shp - $d, $mana - 229, $bhp, $damage, $total + 229, [@stack, 4], %effects, recharge => 4);
    }
  }

  @results = sort {$a->[0] <=> $b->[0]} grep {defined $_} @results;
  return shift @results;
}

my @results = sort {$a->[0] <=> $b->[0]} take_turns($self{hp}, $self{mana}, $boss{hp}, $boss{damage}, 0, []);
print "Mana: ", shift(@{$results[0]}), " @{$results[0]}\n";
my %effects;
sub start_turn {
  my $who = shift @_;

  print "-- $who turn --\n";
  print "- Player has $self{hp} hit points, $self{armor} armor, $self{mana} mana\n";
  print "- Boss has $boss{hp} hit points\n";
  if (defined $effects{shield}) {
    --$effects{shield};
    print "Shield's timer is now $effects{shield}.\n";
    if ($effects{shield} < 1) {
      print "Shield wears off, decreasing armor by 7.\n";
      $self{armor} = 0;
      delete $effects{shield};
    }
  }
  if (defined $effects{poison}) {
    --$effects{poison};
    $boss{hp} -= 3;
    if ($boss{hp} < 1) {
      print "Poison deals 3 damage. This kills the boss, and the player wins.\n";
      exit;
    }
    print "Poison deals 3 damage; its timer is now $effects{poison}.\n";
    if ($effects{poison} < 1) {
      print "Poison wears off.\n";
      delete $effects{poison};
    }
  }
  if (defined $effects{recharge}) {
    --$effects{recharge};
    print "Recharge provides 101 mana; its timer is now $effects{recharge}.\n";
    $self{mana} += 101;
    if ($effects{recharge} < 1) {
      print "Recharge wears off.\n";
      delete $effects{recharge};
    }
  }
}
while (defined($_ = shift @{$results[0]})) {
  start_turn("Player");
  if ($_ == 0) {
    print "Player casts Magic Missile, dealing 4 damage.\n";
    $self{mana} -= 53;
    $boss{hp} -= 4;
  } elsif ($_ == 1) {
    print "Player casts Drain, dealing 2 damage, and healing 2 hit points.\n";
    $self{mana} -= 73;
    $self{hp} += 2;
    $boss{hp} -= 2;
  } elsif ($_ == 2) {
    print "Player casts Shield, increasing armor by 7.\n";
    $self{mana} -= 113;
    $self{armor} = 7;
    $effects{shield} = 6;
  } elsif ($_ == 3) {
    print "Player casts Poison.\n";
    $self{mana} -= 173;
    $effects{poison} = 6;
  } elsif ($_ == 4) {
    print "Player casts Recharge.\n";
    $self{mana} -= 229;
    $effects{recharge} = 5;
  } else {
    die Dumper $results[0];
  }
  print "\n";
  start_turn("Boss");
  my $d = $boss{damage};
  if (defined($effects{shield})) {
    $d -= 7;
    $d = 1 if $d < 1;
    $self{hp} -= $d;
    $d = "$boss{damage} - 7 = $d";
  } else {
    $self{hp} -= $d;
  }
  print "Boss attacks for $d damage!\n";
  print "\n";
}
start_turn("Player");
