package Utils;

use List::Util qw(max);
use Data::Table;


###
###	Input  : Data::Table object
###	Output : new Data::Table object with normalized column widths
###
sub Data::Table::normalize_column_widths
{
	my $t = shift;
	my $c = shift;

	my $dt = $t->clone();

	for my $c ($dt->header) {

		# trim the column - 
		#	ignore non-printable characters, 
		#	replace multiple white spaces with one, 
		#	ignore leading/trailing white space

		$dt->colMap($c, sub { 
			my $in = shift // '';
			$in =~ s/[^[:print:]]+//g unless $c->{non_printable};
			$in =~ s/\s+/ /gs unless $c->{multi_whitespace};
			$in =~ s/^\s*//gs unless $c->{leading_whitespace};
			$in =~ s/\s*$//gs unless $c->{trailing_whitespace};
			return $in;
		});
		my $max_col_width = max map { my $t = $_ // ''; length($t) } $c, @{$dt->colRef($c)};
		$dt->colMap($c, sub { 
			sprintf("%${max_col_width}s", shift);
		});
		$dt->rename($c, sprintf("%${max_col_width}s", $c));
	}
	return $dt;
}
###

1;
