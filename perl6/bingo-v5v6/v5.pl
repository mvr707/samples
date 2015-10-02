#!/usr/bin/env perl

use strict;
use warnings;
use Data::Dumper;
$Data::Dumper::Sortkeys = 1;

my $game = 0;
my $draws = {};
for ([5,27,46,55,67], [14,23,32,47,62], [39,45,44,42,35], [69,49,1,26,10], [74,61,68,73,69]) {
		my $h; 
		@$h{@$_} = @$_; 
		$game++;
		$draws ->{$game} = $h; 
}

my $winners;

sub examine
{
	my %in = @_;
	while (my ($k, $v) = each %in) {
		my @bingo = @$v;
		map { push(@{$winners->{$_}}, $k) if (@bingo == grep { defined } @{$draws->{$_}}{@bingo}) } keys %$draws;
	}
}

### Parse Block
{
	open (my $fh, '<', "bingo.txt") or die;
	my $t = [];
	my ($player, $board);

	while (my $line = <$fh>) {
		next if ($line =~ /^\s*$/);
		chomp($line);
		if ($line =~ /Player:\s*(.*)\s*$/) {
			$player = $1;
			my $tmp = <$fh>;
			if ($tmp =~ /Board:\s*(.*)\s*$/) {
				$board = $1;
			}
			my $id = "$board:$player";

			examine("${id}:h1" => $t->[0],
				"${id}:h2" => $t->[1],
				"${id}:h3" => $t->[2],
				"${id}:h4" => $t->[3],
				"${id}:h5" => $t->[4],
			
				"${id}:v1" => [ $t->[0][0],$t->[1][0],$t->[2][0],$t->[3][0],$t->[4][0] ],
				"${id}:v2" => [ $t->[0][1],$t->[1][1],$t->[2][1],$t->[3][1],$t->[4][1] ],
				"${id}:v3" => [ $t->[0][2],$t->[1][2],$t->[3][2],$t->[4][2] ],
				"${id}:v4" => [ $t->[0][3],$t->[1][3],$t->[2][2],$t->[3][3],$t->[4][3] ],
				"${id}:v5" => [ $t->[0][4],$t->[1][4],$t->[2][3],$t->[3][4],$t->[4][4] ],

				"${id}:df" => [ $t->[0][0],$t->[1][1],$t->[3][3],$t->[4][4] ],
				"${id}:db" => [ $t->[0][4],$t->[1][3],$t->[3][1],$t->[4][0] ]);

			$t = [];
		} else {
			push(@$t, [grep { /\d/ } split(' ', $line)]);
		}
	}
	close($fh);
}

print Data::Dumper->Dump([$winners], ['Winners']);
