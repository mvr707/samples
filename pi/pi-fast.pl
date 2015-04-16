#!/usr/bin/env perl

use strict;
use warnings;

use Math::GMP;

my $digits = 1_000_000;
my $gcd_interval = 10_000;

$| = 1;

my $a = Math::GMP->new(4);
my $b = Math::GMP->new(1);
my $a1 = Math::GMP->new(12);
my $b1 = Math::GMP->new(4);
my $p = Math::GMP->new(1);
my $q = Math::GMP->new(3);
my $i = $gcd_interval;

LOOP: while (1) {
   $p += $q;
   $q += 2;
   ($a, $a1) = ($a1, $p * $a + $q * $a1);
   ($b, $b1) = ($b1, $p * $b + $q * $b1);
   unless (--$i) {
      $i = $gcd_interval;
      my $gcd = $a->bgcd($b)->bgcd($a1)->bgcd($b1);
      $a /= $gcd; $b /= $gcd; $a1 /= $gcd; $b1 /= $gcd;
   }
   while (1) {
      my $d = $a / $b;
      my $d1 = $a1 / $b1;
      last unless $d == $d1;
      print $d;
      last LOOP unless --$digits;
      $a = 10 * ($a - $d * $b);
      $a1 = 10 * ($a1 - $d1 * $b1);
   }
}
