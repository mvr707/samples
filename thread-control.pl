#!/usr/bin/env perl

use strict;
use warnings;

use threads;
use threads::shared;
use Thread::Queue;

use Data::Dumper;

my $res = {};
share($res);

my $num_workers    = 5;
my $num_work_units = 10;

my $q = Thread::Queue->new();

# Create workers
my @workers;
for (1..$num_workers) {
   push @workers, async {
      while (defined(my $unit = $q->dequeue())) {
	 my $i = 10; # int(rand()*10);
         print("BEGIN $unit ($i)\n");
	 sleep($i);
	 $res->{$unit} = shared_clone( { tid => threads->tid(), result => [rand(), rand(), rand()], } );
         print("END $unit ($i)\n");
      }
   };
}


# Create work
for (1..$num_work_units) {
   $q->enqueue($_);
}

# Tell workers they are no longer needed.
$q->enqueue(undef) for @workers;

# Wait for workers to end
$_->join() for @workers;

print Dumper($res);
