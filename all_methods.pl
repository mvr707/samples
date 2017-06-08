#!/usr/bin/env perl

########################################################################################################################
###	Find all methods of a perl object (both direct and inherited methods)
########################################################################################################################
use Modern::Perl;

use Class::MOP;

# Example 1
use Data::Table;
my $dt = Data::Table->new([[11,12,13],[21,22,23],[31,32,33]], [qw/a b c/]);
my $code_ref; # to find number of rows of an object
for my $m (Class::MOP::Class->initialize('Data::Table')->get_all_methods) {
	say "name = ", $m->name;
	say "package_name = ", $m->package_name;
	say "fully_qualified_name = ", $m->fully_qualified_name;
	say "body = ", $m->body;
	say "===";

	if ($m->name eq "nofRow") {
		$code_ref = $m->body;
	}
}
say "Number of rows = ", $code_ref->($dt);


# Example 2
use WWW::Mechanize;
my $agent = WWW::Mechanize->new();
for my $m (Class::MOP::Class->initialize('WWW::Mechanize')->get_all_methods) {
	say "name = ", $m->name;
	say "package_name = ", $m->package_name;
	say "fully_qualified_name = ", $m->fully_qualified_name;	
	say "body = ", $m->body;
	say "===";
}

### Reference: http://www.perlmonks.org/?node_id=741707
