############################################################################
# From: http://blogs.perl.org/users/pawel_bbkr_pabian/2015/09/asynchronous-parallel-and-dead-my-perl-6-daily-bread.html
############################################################################

my %document = (
        '1' => {
            '1.1' => 'Lorem ipsum',
            '1.2' => {
                '1.2.1' => 'Lorem ipsum',
                '1.2.2' => 'Lorem ipsum'
            }
        },
        '2' => {
            '2.1' => {
                '2.1.1' => 'Lorem ipsum'
            }
        }
);

sub process (%chapters) {
        return Promise.allof(
            do for %chapters.kv -> $number, $content {
                my $current = {
                    note "Chapter $number started";
                    sleep 1; # here the chapter itself is processed
                    note "Chapter $number finished";
                };

                if $content ~~ Hash {
                    Promise.allof( &?ROUTINE.($content) )
                        .then( $current );
                }
                else {
                    Promise.start( $current );
                }
            }
        );
}

await process(%document);
