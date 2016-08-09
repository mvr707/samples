#!/usr/bin/env perl

use strict;
use warnings;

use Inline 'Python';
use JSON;

print "9 + 16 = ", add(9, 16), "\n";
print "9 - 16 = ", subtract(9, 16), "\n";

print "result (guess = 0.1) = ", solve(0.1), "\n";
print "result (guess = 5.1) = ", solve(5.1), "\n";

print "quadratic (guess = 0.1) = ", solve_quadratic(1, -3, 2, 0.1), "\n";
print "cubic (guess = 0.1) = ", solve_cubic(1,2,3,4,0.1), "\n";

### Capture the no-solution case via 'eval'
print "quadratic (guess = 0.1) = ", eval 'solve_quadratic(1, 2, 3, 0.1)', "\n";
print "quadratic (guess = 0.1) = ", eval 'solve_quadratic(1, 2, 3, 0.1)', "\n";

### Serialization is the way to send/receive structured data
print "Result = ", sumup(encode_json([11,22,33,44])), "\n";

__END__

all is well

__Python__

from sympy import nsolve
from sympy.abc import r
from sympy.abc import x
import json

def sumup(x):
	h = json.loads(x)
	tmp = 0
	for i in range(len(h)):
		tmp += h[i]
	return tmp

def add(x,y): 
	return x + y

def subtract(x,y):
	return x - y

# a*x**3 + b*x**2 + c*x + d  = 0
def solve_quadratic(a, b, c, d, guess):
	return nsolve(a*x**2 + b*x + c, x, guess)

# a*x**2 + b*x + c  = 0
def solve_quadratic(a, b, c, guess):
	return nsolve(a*x**2 + b*x + c, x, guess)

# a*x**3 + b*x**2 + c*x + d = 0
def solve_cubic(a, b, c, d, guess):
	return nsolve(a*x**3 + b*x**2 + c*x + d, x, guess)

# x**2 - 5*x + 6 = 0  <=> (x - 2)(x - 3) = 0
# 
# Depending on initial guess, one may get 2 or 3
def solve(guess):
	return nsolve(x**2-5*x+6, x, guess)
