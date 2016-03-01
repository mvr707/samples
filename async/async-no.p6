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
	for %chapters.kv -> $number, $content {
            note "Chapter $number started";
            # &?ROUTINE.($content) if $content ~~ Hash;
            process($content) if $content ~~ Hash;
            sleep 1; # here the chapter itself is processed
            note "Chapter $number finished";
        }
}
    
process(%document);
