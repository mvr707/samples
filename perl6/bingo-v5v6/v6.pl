#!/usr/bin/env perl6

my $in = shift @*ARGS;
my @draw = @*ARGS;

my $h;

if "$in.perl".IO.e {
	$h = EVAL "$in.perl".IO.slurp;
	# say $h.perl;
} else {
	my $file = "$in.txt";
	my $t = [];
	my ($player, $board);

	my $fh = open $file, :r;

	while (defined my $line = $fh.get) {
		# say $line;
		$line = $line.trim;
		my ($key, $val);
		next if ($line ~~ /^\s*$/);
		### got: $line
		if ($line ~~ /Player:\s*(.*)\s*$/) {
			$player = split(':', $line)[1];
			my $tmp = $fh.get;
			if ($tmp ~~ /Board:\s*(.*)\s*$/) {
				$board = split(':', $tmp)[1];
			}
			my $id = "{$board}:{$player}";
			for 0..4 -> $i {
				$key = "{$id}:h{$i+1}";
				$val = join(',', sort @($t.[$i]));;
				#$h.{$val} ||= []; 
				push($h.{$val}, $key);
			}
			for 0..4 -> $j {
				$key = "{$id}:v{$j+1}";
				$val = join(',', sort $t.[0][$j],$t.[1][$j],$t.[2][$j],$t.[3][$j],$t.[4][$j]);;
				#$h.{$val} ||= [];
				push($h.{$val}, $key);
			}
			$key = "{$id}:df";
			$val = join(',', sort $t.[0][0],$t.[1][1],$t.[2][2],$t.[3][3],$t.[4][4]);
			#$h.{$val} ||= [];
			push($h.{$val}, $key);
			
			$key = "{$id}:db";
			$val = join(',', sort $t.[0][4],$t.[1][3],$t.[2][2],$t.[3][1],$t.[4][0]);
			#$h.{$val} ||= [];
			push($h.{$val}, $key);

			$t = [];
		} else {
			my $tmp = [split(' ', $line)];
			push($t, $tmp);
		}
	}
	$fh.close;

	$fh = open "{$in}.perl", :w;
	$fh.say($h.perl);
	$fh.close;
}

sub smartmatch($draw, $bingo)
{
	my (%draw, %bingo);
	%draw{split(',', $draw)} = 1;
	%bingo{split(',', $bingo)} = 1;
	for %bingo.keys -> $i {
		next if !($i ~~ /^\d+$/);
		return 0 if !(%draw{$i}:exists);
	}
	return 1;
}

for @draw -> $d {
	print "draw = $d\n";
	my $winners = [];
	for $h.keys -> $i {
		if (smartmatch($d, $i)) {
			push(@$winners, @($h.{$i}));
		}
	}
	### Done
	say $winners;
}

