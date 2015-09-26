use Inline::Perl5;
use Data::Dumper:from<Perl5>;
use CGI:from<Perl5>;
use Digest::MD5:from<Perl5>;

my $h = {a => [1, 11, 111], b => [2, 22, 222], c => [3, 33, 333]};

say Dumper($h);

my $q = CGI.new('a=1&b=2&c=3');

say $q.query_string;

my $ctx = Digest::MD5.new;
$ctx.add("all is well");

say $ctx.hexdigest;
