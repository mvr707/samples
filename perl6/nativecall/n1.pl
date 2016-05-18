#!/usr/bin/env perl

use strict;
use warnings;

my $cid;

if ($cid = fork()) {
	print "[$$]> Here is parent pid = $$\n";
	print "[$$]> Waiting for child $cid to finish\n";

	waitpid($cid, 0);

	print "[$$]> child $cid is done\n";
	print "[$$]> Bye from parent\n";
	exit(0);
}


print "[$$]> Here is child pid = $$\n";
for (my $i=0; $i < 10; $i++) {
	print "[$$]> Child busy ...\n";
	sleep(1);
}
print "[$$]> Bye from child\n";
exit(0);
