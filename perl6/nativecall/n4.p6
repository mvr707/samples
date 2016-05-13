use NativeCall;

sub hello(int32) returns int32 is native('./libn4.so') {};

my $ret = hello(1234);

say "return value is $ret";
