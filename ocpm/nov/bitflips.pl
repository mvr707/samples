#!/usr/bin/env perl

use strict;
use warnings;
use POSIX;

my $verbose = 0;

# number of 0 -> 1 bit flips in counting from 0 to 2^n - 1
sub up_flips
{
        my $n = shift;

        return 1 if (1 == $n);
        return 2*up_flips($n-1) + 1;
}

# number of 1 -> 0 bit flips in counting from 0 to 2^n - 1
sub dn_flips
{
        my $n = shift;

        return 0 if (1 == $n);
        return 2*dn_flips($n-1) + ($n -1);
}

# number of up (0 -> 1) and dn (1 -> 0) bit flips in counting from 0 to 2^n - 1
sub bitflips
{
        my $n = shift;

        return (up_flips($n), dn_flips($n));
}

sub log2
{
        my $in  =shift;
        return (0.0 + log($in)/log(2));
}

# number of (up, dn) bit flips in counting 0 to N
sub BitFlips
{
        my $N = shift;

        my $residue = 0;

        if (0 == $N) {
                return (0, 0);
        }

        my $bits_lower = floor(log2($N+1));
        my $bits_upper = ceil(log2($N+1));

print <<EOF if ($verbose);
bits_lower = $bits_lower
bits_upper = $bits_upper
EOF

        my $count_lower = 2**$bits_lower;
        my $count_upper = 2**$bits_upper;

        my ($up, $dn) = bitflips($bits_lower);

print <<EOF if ($verbose);
up = $up
dn = $dn
EOF

        if ($N+1 - $count_lower > 0) {
                $up += 1;
                $dn += $bits_upper - 1;

                $residue = $N+1 - $count_lower - 1;
                my ($u, $d) = BitFlips($residue);

                $up += $u;
                $dn += $d;
        }
        return ($up, $dn);
}

my ($from, $to) = ($ARGV[0], $ARGV[1]);

my ($up_f, $dn_f) = BitFlips($from);
my ($up_t, $dn_t) = BitFlips($to);

my ($up, $dn) = ($up_t - $up_f, $dn_t - $dn_f);

print <<EOF;
(up, dn) = ($up, $dn)
EOF
