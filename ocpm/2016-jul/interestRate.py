from sympy import nsolve
from sympy.abc import x
from sympy.abc import r

#########################################
### D: stetment date (2016-06-30)
### P: account value on statement date (400)
###
### d: date, p: principal, n: number of days from statement date
#########################################
###          d|   p|  n
### 2016-01-10| 100|172
### 2016-01-23|  50|159
### 2016-01-30| -25|152
### 2016-02-10|  80|141
### 2016-03-20| 125|102
### 2016-04-15|-130| 76
### 2016-05-05|  25| 56
### 2016-05-26|  45| 35
### 2016-06-18| 102| 12
### 2016-06-30|    |   
#########################################


#########################################
### Equation based on cumulative daily account balance
#########################################
def f():

    # Initialize based on data from 1st and 2nd rows
    eq = ((100 * (1 + x / 365) ** 13) + 50)

    # Use a for loop to traverse through the rows and add to the equation
    eq = ((eq * (1 + x / 365) ** 7) - 25)
    eq = ((eq * (1 + x / 365) ** 11) + 80)
    eq = ((eq * (1 + x / 365) ** 39) + 125)
    eq = ((eq * (1 + x / 365) ** 26) - 130)
    eq = ((eq * (1 + x / 365) ** 20) + 25)
    eq = ((eq * (1 + x / 365) ** 21) + 45)
    eq = ((eq * (1 + x / 365) ** 23) + 102)

    # After the last row, find how many days till D and subtract P
    # to make eq equal to 0. Use nsolve to solve.
    eq = (eq * (1 + x / 365) ** 12) - 400

    print nsolve(eq, x, 0.0001)

#########################################
### Equation based on sum of each deposit growth
#########################################
def g():
    acct = 100*(1+r)**172 
    acct += 50*(1+r)**159
    acct -= 25*(1+r)**152
    acct += 80*(1+r)**141
    acct += 125*(1+r)**102
    acct -= 130*(1+r)**76
    acct += 25*(1+r)**56
    acct += 45*(1+r)**35
    acct += 102*(1+r)**12
    acct -= 400

    print nsolve(acct, r, 0.0001) * 365

#########################################
### Daily compounded interest rate will be same!
#########################################
if __name__ == "__main__":
    f()
    g()
