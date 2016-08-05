print "9 + 16 = ", add(9, 16), "\n";
print "9 - 16 = ", subtract(9, 16), "\n";

print "result (guess = 0.1) = ", solve(0.1), "\n";
print "result (guess = 5.1) = ", solve(5.1), "\n";

use Inline Python => <<'END_OF_PYTHON_CODE';

from sympy import nsolve
from sympy.abc import r
from sympy.abc import x

def add(x,y): 
	return x + y

def subtract(x,y):
	return x - y

def solve(guess):
	return nsolve(x**2-5*x+6, x, guess)

END_OF_PYTHON_CODE
