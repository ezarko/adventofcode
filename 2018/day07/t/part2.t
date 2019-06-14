use Test::More tests => 1;

is(`./part2.pl 1 0 sample.txt`, "15\n", 'part2.pl sample.txt produces 15');
is(`./part2.pl 4 60 input.txt`, "BDHNEGOLQASVWYPXUMZJIKRTFC\n", 'part2.pl input.txt produces BDHNEGOLQASVWYPXUMZJIKRTFC');
