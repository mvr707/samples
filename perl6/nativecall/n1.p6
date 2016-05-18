use NativeCall;

sub fork() returns int32 is native {};
sub waitpid(int32, int32) is native {};

my $cid;

if ($cid = fork()) {
	say "[$*PID]> Here is parent pid = $*PID";
	say "[$*PID]> Waiting for child $cid to finish";

	waitpid($cid, 0);

	say "[$*PID]> child $cid is done";
	say "[$*PID]> Bye from parent";
	exit(0);
}


say "[$*PID]> Here is child pid = $*PID";
loop (my $i=0; $i < 10; $i++) {
	say "[$*PID]> Child busy ...";
	sleep(1);
}
say "[$*PID]> Bye from child";
exit(0);
