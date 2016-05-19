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

sub calculate(int32 is rw, int32 is rw)
	is native('./libn3.so') { };
my int32 ($x, $y) = (3,45);
say "$x and $y";
calculate($x, $y);
say "$x and $y";
say "---";

##################################################################

sub get-name-by-value() returns Str
	is symbol('get_name')
	is native('./libn3.so') { };
sub print-name(Pointer[int8])
	is symbol('print_name')
	is native('./libn3.so') { };

my $n1 = get-name-by-value();
my $n2 = get-name-by-value();
my $n3 = get-name-by-value();
say $n1;
say $n2;
say $n3;

say "---";


sub get-name-by-ref() returns Pointer[int8]
	is symbol('get_name')
	is native('./libn3.so') { };
$n1 = get-name-by-ref();
$n2 = get-name-by-ref();
$n3 = get-name-by-ref();
say $n1;
say $n2;
say $n3;
print-name($n1);
print-name($n2);
print-name($n3);
say "---";

##################################################################

sub sumup(int32, CArray[int32]) returns int32
	is native('./libn3.so') { * }

my $a = CArray[int32].new(10, 20, 30);
$a[3] = 40;

my $sumup = sumup($a.elems, $a);

say "sumup is $sumup";
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
