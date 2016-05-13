use NativeCall;

sub hello(int32) returns int32 is native('./libn2.so') {};

my $ret = hello(234);

say "return value is $ret";
