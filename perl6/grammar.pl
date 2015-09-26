
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

for @experssions -> $exp {
    print $exp, " ";
    my $result = Add1.parse($exp);
    say $result ?? 'OK' !! 'NOT OK'; 
    CATCH {
        say "exception received: $!";
    }
}


