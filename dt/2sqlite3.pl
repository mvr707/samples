#!/usr/bin/env perl

use strict;
use warnings;

use Data::Table;
use Data::Dumper;
use File::Basename;

my $dbname = shift;

for my $filename (@ARGV) {

my $basename = basename($filename);
my $command_file = ".2sqlite3.$basename.in";
my $data_file = ".2sqlite3.$basename.tsv";

my ($tablename, $type) = ('', '');

if ($basename =~ /^(.*)\.(.*?)$/) {
	$tablename = $1;
	$type = lc($2);

	$tablename =~ s/\W/_/g;
}

my ($tableObjects, $tableNames, $column_headers) = ([], [], []);

if ($type eq "csv" or $type eq "tsv") {
	my $dt = Data::Table::fromFile($filename);
	push(@$tableObjects, $dt);
	push(@$tableNames, $tablename);
	push(@$column_headers, [$dt->header]);
} elsif ($type eq "xls" or $type eq "xlsx") {
	($tableObjects, $tableNames, $column_headers) = excelFileToTable("NorthWind.xlsx");
}

for (my $i=0; $i<@$tableNames; $i++) {
	print "*** " . $tableNames->[$i] . " ***\n";

	open(my $fh, '>', $data_file);
	print $fh $tableObjects->[$i]->tsv($column_headers->[$i]);
	close($fh);

my $columns = join(",", map { '"' . $_ . '"' } @{$column_headers->[$i]});
open($fh, '>', $command_file);
print $fh <<EOF;

CREATE TABLE IF NOT EXISTS $tableNames->[$i] ($columns);
.separator "\\t"
.import $data_file $tablename
.quit

EOF

close($fh);

system("sqlite3 $dbname < $command_file");

}

}



__END__

CREATE TABLE IF NOT EXISTS foo (id INTEGER, ...);
