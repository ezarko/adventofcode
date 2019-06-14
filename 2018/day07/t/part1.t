use Test::More tests => 2;

is(`./part1.pl sample.txt`, "CABDFE\n", 'part1.pl sample.txt produces CABDFE');
is(`./part1.pl input.txt`, "BDHNEGOLQASVWYPXUMZJIKRTFC\n", 'part1.pl input.txt produces BDHNEGOLQASVWYPXUMZJIKRTFC');
