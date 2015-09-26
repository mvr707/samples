
my @experssions = (
    "2 + 3",
    "2 + 4 ",
    "2 + 3 x",
    "2 +",
    "2 3",
    "2 - 3",
);

grammar Add1 {
    rule TOP { ^ <math> $ }
    rule math { <operand> <operator> <operand> }
    token operand { \d+ }
    token operator { <[\+\*]> }
}

grammar Add2 {
    rule TOP { ^ <math> $ }
    rule math { 
        <operand>
        [ <operator> || { warn "missing operator"} ] 
        [ <operand> || { warn "Missing second operand" } ]
        [ \S { warn "Invalid value after the second operand" } ]?
    }
    token operand { \d+ }
    token operator { <[\+\*]> || \D { warn "Invalid operator" } }
}

for @experssions -> $exp {
    print $exp, " ";
    my $result;
    try {
	$result = Add2.parse($exp);
    };
    say $result ?? 'OK' !! 'NOT OK'; 
    CATCH {
        say "exception received: $!";
    }
}


