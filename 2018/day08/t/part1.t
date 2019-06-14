use Test::More tests => 2;

is(`./part1.pl sample.txt`, "138\n", 'part1.pl sample.txt produces 138');
is(`./part1.pl input.txt`, "44838\n", 'part1.pl input.txt produces 44838');
