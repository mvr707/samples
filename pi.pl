#!/usr/bin/perl

use strict;
use warnings;

### Gnu Multi Precision library
use Math::GMP;

### Continued Fraction Algorithm http://www.cs.utsa.edu/~wagner/pi/ruby/pi_works.html

$| = 1;

my ($k, $a, $b, $a1, $b1) = (Math::GMP->new(2), Math::GMP->new(4), Math::GMP->new(1), Math::GMP->new(12), Math::GMP->new(4));

while (1) {
  my ($p, $q, $d, $d1) = (Math::GMP->new(0), Math::GMP->new(0), Math::GMP->new(0), Math::GMP->new(0));
  ($p, $q, $k) = ($k*$k, 2*$k+1, $k+1);
  ($a, $b, $a1, $b1) = ($a1, $b1, $p*$a+$q*$a1, $p*$b+$q*$b1);
  ($d, $d1) = ($a/$b, $a1/$b1);
  while ($d == $d1) {
    print $d;
    ($a, $a1) = (10*($a%$b), 10*($a1%$b1));
    ($d, $d1) = ($a/$b, $a1/$b1);
  }
}
