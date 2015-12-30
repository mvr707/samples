#!/usr/bin/env perl6

my %input;
my $index = 0;

for @*ARGS[0].IO.lines {
	%input{$_}<count>++;
	$index++;
	%input{$_}<lines>.push($index);
}

for %input.keys.sort: { %input{$^b}<count> <=> %input{$^a}<count> } {
        last if %input{$_}<count> == 1;
        say "%input{$_}<count>\t$_\t%input{$_}<lines>.join(',')";
}
