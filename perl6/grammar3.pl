
my @experssions = (
    "2 + 3",
    "2 + 4 ",
    "2 + 3 x",
    "2 +",
    "2 3",
    "2 - 3",
);

grammar Expr1 {
    rule TOP { ^ <math> $ }
    rule math { <operand> <operator> <operand> }
    token operand { \d+ }
    token operator { <[\+\*]> }
}

grammar Expr2 {
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

class Actions {
    method TOP($/) {
        $/.say;
    }
}

my $actions = Actions.new;

for @experssions -> $exp {
    print $exp, " ";
    my $result;
    try {
	$result = Expr2.parse($exp, :$actions);
    };
    say $result ?? 'OK' !! 'NOT OK'; 
    CATCH {
        say "exception received: $!";
    }
}


