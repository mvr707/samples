use NativeCall;

my $var = cglobal('./libn3.so', 'My_variable', num64);

sub fact(int32) returns int32 is native('./libn3.so') { };

sub my-mod(int32, int32) returns int32 is symbol('my_mod') is native('./libn3.so') { };

say fact(4);

say my-mod 23, 7;

say $var + 4.5;
