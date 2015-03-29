#!/usr/bin/perl

use strict;
use warnings;

### Gnu Multi Precision library
use Math::GMP;

### Continued Fraction Algorithm http://www.cs.utsa.edu/~wagner/pi/ruby/pi_works.html

$| = 1;

my ($count, $k, $a, $b, $a1, $b1) = (
	Math::GMP->new($ARGV[0] || 0), 
	Math::GMP->new($ARGV[1] || 2), 
	Math::GMP->new($ARGV[2] || 4), 
	Math::GMP->new($ARGV[3] || 1), 
	Math::GMP->new($ARGV[4] || 12), 
	Math::GMP->new($ARGV[5] || 4),
);

my $limit = $ARGV[6] // 100;

top:
while (1) {
  my $snap = "$count $k $a $b $a1 $b1";
  my ($p, $q, $d, $d1) = (Math::GMP->new(0), Math::GMP->new(0), Math::GMP->new(0), Math::GMP->new(0));
  ($p, $q, $k) = ($k*$k, 2*$k+1, $k+1);
  ($a, $b, $a1, $b1) = ($a1, $b1, $p*$a+$q*$a1, $p*$b+$q*$b1);
  ($d, $d1) = ($a/$b, $a1/$b1);
  my $tmp = 0;
  while ($d == $d1) {
    $count++;
    $tmp++;
    print "$count ==> $d\n";
    exit(0) if ($limit == $count);
    ($a, $a1) = (10*($a%$b), 10*($a1%$b1));
    ($d, $d1) = ($a/$b, $a1/$b1);
  }
  if ($tmp) {
	open(my $fh, '>', 'cache.txt') or die;
	print $fh "$snap\n";
	close($fh);
  }
}
