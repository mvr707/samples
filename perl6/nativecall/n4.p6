use NativeCall;


my $var = cglobal('./libn4.so', 'my_variable', num64);

sub hello(int32) returns int32 is native('./libn4.so') is mangled { ... };

my $ret = hello(1234);

say "return value is $ret";

say $var + 10;

class Rectangle is repr<CPPStruct> {
	has num64 $.width;
	has num64 $.height;

	method set_values(num64, num64) is native('./libn4.so') { ... };
	method area() returns num64 is native('./libn4.so') { ... };
};

my $r = Rectangle.new;

my $width = $var + 10;
my $height = $var + 5;

$r.set_values($width, $height);

say "area = { $r.area() }";

