use NativeCall;


my $var = cglobal('./libn4.so', 'my_variable', num64);

sub hello(int32) returns int32 is native('./libn4.so') is mangled { ... };

my $ret = hello(1234);

say "return value is $ret";

say $var + 10;

class Rectangle is repr<CPPStruct> {
	has int32 $.width;
	has int32 $.height;

	method set_values(int32, int32) is native('./libn4.so') { ... };
	method area() returns int32 is native('./libn4.so') { ... };
};

my $r = Rectangle.new;

$r.set_values(3,4);

say "area = { $r.area() }";

