#!/usr/bin/env perl6

use experimental :cached;
use Bench;

sub MAIN
(
	Bool :d(:$debug) = False,
	Str :l(:$label) = ’answer: ’,
	Rat :$n = 1/3,
	Int :$p!,
	Int :$iter = 100,
)
{
	($debug) and say "print label and compute";
	say $label, $n**$p;

	subset3().say;
	# say "fib $p = ",  fib($p);
	# say "gib $p = ",  gib($p);
	# say "hib $p = ",  hib($p);

	Bench.new.timethese($iter, {
	  first  => sub { subset1(); },
	  second => sub { subset2(); },
	  third  => sub { subset3(); },
	});
}

sub subset1 
{
	my @a = 1,2,3,4,5,6,7,8,9,10,1,2,3,4,5,6,7,8,9,10;
	my @b = 1,3,5,7,9,1,3,5,7,9;

	all(@b) == any(@a);
}

sub subset2 
{
	my $a = set 1,2,3,4,5,6,7,8,9,10,1,2,3,4,5,6,7,8,9,10;
	my $b = set 1,3,5,7,9,1,3,5,7,9;

	$b (<) $a;
}

sub subset3 
{
	my @a = 1,2,3,4,5,6,7,8,9,10,1,2,3,4,5,6,7,8,9,10;
	my @b = 1,3,5,7,9,1,3,5,7,9;

	my %a;
	my %b;

	%a{@a} = 1;
	%b{@b} = 1;

	for %b.keys -> $i {
		if !(%a{$i}:exists) { return 0; }
	}
	return 1;
}


sub fib (Int $nth where * >= 0) #is cached
{
	given $nth
	{
		when 0 { return 0; }
		when 1 { return 1; }
		default { return (fib $nth - 1) + (fib $nth - 2); }
	}
}

multi gib(Int $nth where * == 0) { return 0; }
multi gib(Int $nth where * == 1) { return 1; }
multi gib(Int $nth where * >= 2) { return (gib $nth - 1) + (gib $nth - 2); }

sub hib(Int $nth where * >= 0) #is cached 
{ my @t = 0, 1, -> $x, $y { $x + $y } ... *; return @t[$nth]; }
