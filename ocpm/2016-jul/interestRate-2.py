#!/usr/bin/env python

from sympy import nsolve
from sympy.abc import r
from sympy.abc import x

r = nsolve(100*(1+r)**172 + 50*(1+r)**159 - 25*(1+r)**152 + 80*(1+r)**141 + 125*(1+r)**102 - 130*(1+r)**76 + 25*(1+r)**56 + 45*(1+r)**35 + 102*(1+r)**12 - 400, r, 0.0001)

print "r = ", r * 365 * 100

eq = ((100 * (1 + x) ** 13) + 50)
eq = ((eq * (1 + x) ** 7) - 25)
eq = ((eq * (1 + x) ** 11) + 80)
eq = ((eq * (1 + x) ** 39) + 125)
eq = ((eq * (1 + x) ** 26) - 130)
eq = ((eq * (1 + x) ** 20) + 25)
eq = ((eq * (1 + x) ** 21) + 45)
eq = ((eq * (1 + x) ** 23) + 102)

# After the last row, find how many days till D and subtract P
# to make eq equal to 0. Use nsolve to solve.
eq = (eq * (1 + x) ** 12) - 400

x = nsolve(eq, x, 0.0001)
print "x = ", x * 365 * 100
