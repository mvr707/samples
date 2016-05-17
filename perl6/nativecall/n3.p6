use NativeCall;

##################################################################

my $var = cglobal('./libn3.so', 'My_variable', num64);
say $var + 4.5;
say "---";

##################################################################

sub fact(int32) returns int32 
	is native('./libn3.so') { };
say fact(4);
say "---";

##################################################################

sub my-mod(int32, int32) returns int32 
	is symbol('my_mod') 
	is native('./libn3.so') { };
say my-mod 23, 7;
say "---";

##################################################################

sub get-name() returns Str
	is symbol('get_name')
	is native('./libn3.so') { };
my $n1 = get-name();
my $n2 = get-name();
my $n3 = get-name();
say $n1;
say $n2;
say $n3;
say "---";

##################################################################

class SumDiff is repr('CStruct') {
	has int32 $.sum;
	has int32 $.diff;
};
sub sumdiff(int32, int32) returns SumDiff
	is native('./libn3.so') { };
my $result = SumDiff.new;
say $result;
say nativesizeof($result);
my $res = sumdiff(4,50);
say $res;
say "sum is ", $res.sum;
say "diff is ", $res.diff;
say "---";

##################################################################

sub get-list(int32) returns CArray[Str]
	is symbol('get_list')
	is native('./libn3.so') { };

my $length = 3;

my CArray[Str] $list = get-list($length);
say nativesizeof($list);

for ^$length { say $list[$_] };
