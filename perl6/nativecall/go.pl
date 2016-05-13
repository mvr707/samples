use v6;
use NativeCall;

sub fork() returns int32 is native { ... }

my $children = 15;
for 1 .. $children -> $child {
    my $pid = fork();
    if $pid {
        print "created child $child process $pid. ";
        sleep 1; print "snore. ";
    }
    else {
        for $child .. $children { sleep 1; print "yawn $child. "; }
        exit 0;
    }
}
