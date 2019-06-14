use Test::More tests => 2;

is(`./part2.pl sample.txt`, "66\n", 'part2.pl sample.txt produces 66');
is(`./part2.pl input.txt`, "22198\n", 'part2.pl input.txt produces 22198');
