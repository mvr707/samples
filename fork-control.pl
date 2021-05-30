#!/usr/bin/env perl

use strict;
use warnings;

use Parallel::ForkManager;
use Data::Dumper;
use IPC::Shareable;

 
my $pm = Parallel::ForkManager->new(5);

my @all_data = (10,20,30,40,50,15,25,35,45,55,65);

my $res = {};
my $handle = tie $res, 'IPC::Shareable', undef, { destroy => 1 };
 
DATA_LOOP:
foreach my $data (@all_data) {
	# Forks and returns the pid for the child:
	my $pid;
	my $i = int(10 * rand());
	if ($pid = $pm->start) {
		next DATA_LOOP;
	} else {
		print "BEGIN $$ ($i)\n";
		sleep($i);
		$handle->shlock();
		$res->{$$} = [rand(), rand(), rand()];
		$handle->shunlock();
		print "END $$\n";
  		$pm->finish; # Terminates the child process
	}
}
print "$$ Parent all done, and waiting\n";
$pm->wait_all_children;

print Dumper($res);

$handle->remove;		### seems to be nice to do
IPC::Shareable->clean_up;	### seems to be nice to do
IPC::Shareable->clean_up_all; 	### This seems to be the real statement that releases shared memory
