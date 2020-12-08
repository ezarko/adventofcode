#!/usr/bin/perl

use strict;
use warnings;

use Data::Dumper;
use File::Slurp;

my $data = read_file('input.txt');

my @records = $data =~ /((?:(?:byr:(?:19[2-9]\d|200[0-2])|iyr:20(?:1\d|20)|eyr:20(?:2\d|30)|hgt:(?:(?:1[5-8]\d|19[0-3])cm|(?:59|6\d|7[0-6])in)|hcl:#[0-9a-f]{6}|ecl:(?:amb|blu|brn|gry|grn|hzl|oth)|pid:(?:\d{9}))\s){7}|(?:(?:byr:(?:19[2-9]\d|200[0-2])|iyr:20(?:1\d|20)|eyr:20(?:2\d|30)|hgt:(?:(?:1[5-8]\d|19[0-3])cm|(?:59|6\d|7[0-6])in)|hcl:#[0-9a-f]{6}|ecl:(?:amb|blu|brn|gry|grn|hzl|oth)|pid:(?:\d{9})|cid:\S*)\s){8})/sg;
print @records."\n";
