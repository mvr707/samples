#!/usr/bin/env perl6

#`{{{
	Install module

 	% panda install Bench
}}}

use Bench;

my $b = Bench.new;

$b.timethese(100, {
  first  => sub { sleep .05; },
  second => sub { sleep .005; },
});
'---------------------------------------------------------'.say;
