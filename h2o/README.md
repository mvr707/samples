THE CHALLENGE:

Write a function to convert a given "Hash" (flat "employee, supervisor") to a "Org" (hierarchical).

DETAILS:


H2O : Hash to Org


Employee <=> Supervisor relationship can be represented as a Hash e.g. (a => b, b => c, d => c, x => y, y => d)
Org is a hierarchical representation of the same data. e.g.


$Org = {
             c => {
                       b => {
                                 a => {},
                       },
                       d => {
                                 y => {
                                          x => {},
                       },
}


