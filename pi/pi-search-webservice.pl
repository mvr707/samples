#!/usr/bin/env perl

# π (PIE) is conjectured to be a "Normal" number, which means, it contains all finite strings in its expansion.
# That means, under appropriate encoding, entire universe (all events, pictures, videos, all books/music ever produced
# in the past or will be produced in future is all in there!!!
#
#
# The following website allows us to query strings in π up to 200M digits in the expansion. http://www.angio.net/pi/piquery.html
#
# All birthdays in 2015 can be represented in format 2015MMDD
#
# E.g. The 4th July 2015 is represented by string 20150704 occurs at position 86,897,846  counting from the first digit after the decimal point
#
# Challenge: Among 365 days in the year 2015, find all days that do not figure in the 200M digits of π

use strict;
use warnings;

use WWW::Mechanize;
use JSON;

my $agent = WWW::Mechanize->new();

my $header;
my $data = [];

for my $i (@ARGV) {
	my $response = decode_json $agent->post('http://www.angio.net/newpi/piquery', [q => $i])->content();
	### verbose: $response 
	print "$i\n" if (!$response->{results}[0]{c});
}

# Usage:
#	bash$ perl -MSmart::Comments script.pl 20150430 20150614
#
# 	bash$ script.pl 2015{01..12}{01..31}
