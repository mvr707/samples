#!/usr/bin/env perl6

#use strict;
#use warnings;

### Gnu Multi Precision library
# use Math::GMP;

### Continued Fraction Algorithm http://www.cs.utsa.edu/~wagner/pi/ruby/pi_works.html
### Pi query allows one to search 200M digits http://www.angio.net/pi/piquery.html

#$| = 1;

#my ($k, $a, $b, $a1, $b1) = (Math::GMP->new(2), Math::GMP->new(4), Math::GMP->new(1), Math::GMP->new(12), Math::GMP->new(4));
my ($k, $a, $b, $a1, $b1) = (2, 4, 1, 12, 4);

while (1) {
  #my ($p, $q, $d, $d1) = (Math::GMP->new(0), Math::GMP->new(0), Math::GMP->new(0), Math::GMP->new(0));
  my ($p, $q, $d, $d1) = (0, 0, 0, 0);
  ($p, $q, $k) = ($k*$k, 2*$k+1, $k+1);
  ($a, $b, $a1, $b1) = ($a1, $b1, $p*$a+$q*$a1, $p*$b+$q*$b1);
  ($d, $d1) = ($a div $b, $a1 div $b1);
  while ($d == $d1) {
    print $d;
    ($a, $a1) = (10*($a%$b), 10*($a1%$b1));
    ($d, $d1) = ($a div $b, $a1 div $b1);
  }
}
