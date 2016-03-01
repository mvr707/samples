#!/usr/bin/env perl6

my %dict = (
	zero	=> 0,
	one	=> 1,
	two	=> 2,
	three	=> 3,
	four	=> 4,
	five	=> 5,
	six	=> 6,
	seven	=> 7,
	eight	=> 8,
	nine	=> 9,
	ten	=> 10,
	eleven		=> 11,
	twelve		=> 12,
	thirteen	=> 13,
	fourteen	=> 14,
	fifteen		=> 15,
	sixteen		=> 16,
	seventeen	=> 17,
	eighteen	=> 18,
	nineteen	=> 19,
	twenty		=> 20,
	thirty	=> 30,
	forty	=> 40,
	fifty	=> 50,
	sixty	=> 60,
	seventy	=> 70,
	eighty	=> 80,
	ninety	=> 90,
	hundred	=> 100,
	thousand	=> 1000,
);

my %wordcounts = ();	# words   -> _normalized
my %numeric = ();	# number -> words

my @lines = 'wordcounts.txt'.IO.lines;
for @lines -> $line {
	%wordcounts{$line} = $line.split('').sort.join('');

	my @w = $line.split(' ');
	my $val = 0;
	my $i = 0;
	my $number_of_words = @w.elems;
	while $i < $number_of_words {
		if @w[$i] eq 'and' {
			$i++;
			next;
		}
		if defined(%dict{@w[$i]}) {
			$val += %dict{@w[$i]};
			$i++;
			if ($i < $number_of_words && defined(%dict{@w[$i]})) {
				$val *= %dict{@w[$i]};
				$i++;
			}
		} elsif (@w[$i] ~~ /(\w+?)\-(\w+)/) {
			$val += %dict{$0} + %dict{$1};
			$i++;
		}
	}
	%numeric{$val} = $line;

	#say "$line, $val";
}
#say %wordcounts;

my %scrambled = ();	# _normalized -> scrambled

@lines = 'scrambled.txt'.IO.lines;
for @lines -> $line {
	my $normalized = $line.split('').sort.join('');
	%scrambled{$normalized}.push($line);
}

#say %scrambled;

# wordcounts 	words   -> _normalized
# numeric 	number -> words
# scrambled 	_normalized -> scrambled

for %numeric.keys.sort({$^a <=> $^b}) -> $n {
	my $w = %numeric{$n};
	my $normalized = %wordcounts{$w};
	my $s = %scrambled{$normalized}.join('|');
	say "$n,$w,$s,'$normalized'";
}
