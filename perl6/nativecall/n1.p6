use NativeCall;

sub fork() returns int32 is native {};

given fork() {
    when 0     { say "I'm a kid!";                      };
    when * > 0 { say "I'm a parent. The kid is at $_";  };
    default    { die "Failed :(";                       };
}

sleep 5;
say "Hello, World! PID = $*PID";

