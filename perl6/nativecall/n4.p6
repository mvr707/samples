use NativeCall;


my $var = cglobal('./libn4.so', 'My_variable', num64);

sub hello(int32) returns int32 is native('./libn4.so') is mangled { ... };

my $ret = hello(1234);

say "return value is $ret";

say $var + 10;
