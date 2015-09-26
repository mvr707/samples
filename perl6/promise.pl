#!/usr/bin/env perl6

my $ans = 100;

my $p1 = start {
    my $i = 0;
    for 1 .. 10 {
        $i += $_;
	$ans++;
	say "p1 - $ans";
	sleep 3;
    }
    $i
};
my $p2 = start {
    my $i = 0;
    for 1 .. 10 {
        $i -= $_;
	$ans++;
	say "p2 - $ans";
	sleep 3;
    }
    $i
};
my @result = await $p1, $p2;
say @result; 

say "ans = $ans";
