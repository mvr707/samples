#!/usr/bin/env perl

use strict;
use warnings;

use threads;
use threads::shared;

use Benchmark qw(:all) ;

my $iteration_count = $ARGV[0] || 10;
my $number_count = $ARGV[1] || 1000000;

my ($s, $a); # Store squential and asynchronous results
($s = sequential()) == ($a = asynchronous()) || die "sequential ($s) and asynchronous ($a) results are different\n";

print <<EOF;
sequential result = $s
async result      = $a
EOF

timethese(10, {
	'Sequential' => 'sequential()',
	'Asynchronous' => 'asynchronous()',
});

sub sequential {
	my $res = 0;
	for my $i (1..$iteration_count) {
		{
			for my $k (1..$number_count) {
				$res += $k;
			}
		}
	}
	return $res;
}

sub asynchronous {
	my $t;
	my $res : shared = 0;
	for my $i (1..$iteration_count) {
		$t->[$i] = async {
			my $tmp = 0;
			for my $k (1..$number_count) {
				$tmp += $k;
			}
			lock($res);
			$res += $tmp;
		}
	}
	map { $t->[$_]->join(); } 1..$iteration_count;
	return $res;
}


__END__

[QuadCore]
pi@RPi2 ~ $ perl async.pl
sequential result = 5000005000000
async result      = 5000005000000
Benchmark: timing 10 iterations of Asynchronous, Sequential...
Asynchronous: 36 wallclock secs (109.70 usr +  0.23 sys = 109.93 CPU) @  0.09/s (n=10)
Sequential: 102 wallclock secs (101.70 usr +  0.09 sys = 101.79 CPU) @  0.10/s (n=10)

[SingleCore]
pi@Rpi1 ~ $ perl async.pl 
sequential result = 5000005000000
async result      = 5000005000000
Benchmark: timing 10 iterations of Asynchronous, Sequential...
Asynchronous: 199 wallclock secs (178.31 usr +  3.46 sys = 181.77 CPU) @  0.06/s (n=10)
Sequential: 183 wallclock secs (165.07 usr +  1.76 sys = 166.83 CPU) @  0.06/s (n=10)
