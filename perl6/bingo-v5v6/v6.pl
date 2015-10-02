#!/usr/bin/env perl6

my $game = 0;
my %draws;

for (5,27,46,55,67), (14,23,32,47,62), (39,45,44,42,35), (69,49,1,26,10), (74,61,68,73,69) {
		my %h; 
		%h{$_} = $_; 
		$game++;
		%draws{$game} = %h; 
}

my %winners;

sub examine(%in)
{
	for %in.kv -> $id, $bingo {
		# %draws.keys.map({ %winners{$_}.push($id) if ($bingo.elems == %draws{$_}{@($bingo)}.grep({$_.defined}).elems) });
		
		for %draws.keys -> $g {
			if ($bingo.elems == %draws{$g}{@($bingo)}.grep({$_.defined}).elems) {
				%winners{$g}.push($id);
			}
		}
	}
}

### Parse Block
{
	my $fh = open "bingo.txt", :r;
	my @t = ();
	my ($player, $board);

	while (defined my $line = $fh.get) {
		next if ($line ~~ /^\s*$/);
		$line = $line.trim;
		if ($line ~~ /Player/) {
			$player = $line.split(':')[1];
			my $tmp = $fh.get;
			if ($tmp ~~ /Board/) {
				$board = $tmp.split(':')[1];
			}
			my $id = "{$board}:{$player}";

			examine({"{$id}:h1" => @t[0],
				"{$id}:h2" => @t[1],
				"{$id}:h3" => @t[2],
				"{$id}:h4" => @t[3],
				"{$id}:h5" => @t[4],
			
				"{$id}:v1" => [ @t[0][0],@t[1][0],@t[2][0],@t[3][0],@t[4][0] ],
				"{$id}:v2" => [ @t[0][1],@t[1][1],@t[2][1],@t[3][1],@t[4][1] ],
				"{$id}:v3" => [ @t[0][2],@t[1][2],@t[3][2],@t[4][2] ],
				"{$id}:v4" => [ @t[0][3],@t[1][3],@t[2][2],@t[3][3],@t[4][3] ],
				"{$id}:v5" => [ @t[0][4],@t[1][4],@t[2][3],@t[3][4],@t[4][4] ],

				"{$id}:df" => [ @t[0][0],@t[1][1],@t[3][3],@t[4][4] ],
				"{$id}:db" => [ @t[0][4],@t[1][3],@t[3][1],@t[4][0] ]});

			@t = ();
		} else {
			push(@t, [$line.split(' ').grep(/\d/)]);
		}
	}
	$fh.close;
}

%winners.say;
