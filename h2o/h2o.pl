#!/usr/bin/env perl

use strict;
use warnings;

use YAML;
use H2O;

my $file = $ARGV[0];

### Start with csv to hash conversion 
### StartTime: time()

my $h = H2O::csv2hashref($file);

### Done with conversion
### EndTime: time()

### Here is the HASH: $h

my $org = H2O::h2o($h);
### Org: Dumper($org)
### XML: XMLout($org)
print Dump($org);
