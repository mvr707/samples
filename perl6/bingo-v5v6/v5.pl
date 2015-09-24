#!/usr/bin/env perl

use strict;
use warnings;
use Data::Dumper;
$Data::Dumper::Sortkeys = 1;

my $in = shift;
my @draw = @ARGV;

my $h = {};

if (-e "${in}.perl") {
	$h = do "${in}.perl";
} else {
	open (my $fh, '<', "${in}.txt") or die;
	my $t = [];
	my ($player, $board);

	while (my $line = <$fh>) {
		my ($key, $val);
		next if ($line =~ /^\s*$/);
		chomp($line);
		### got: $line
		if ($line =~ /Player:\s*(.*)\s*$/) {
			$player = $1;
			my $tmp = <$fh>;
			if ($tmp =~ /Board:\s*(.*)\s*$/) {
				$board = $1;
			}
			my $id = "$board:$player";
			for my $i (0..4) {
				$key = $id . ':' . 'h' . ($i+1);
				$val = join(',', sort @{$t->[$i]});;
				$h->{$val} ||= []; 
				push(@{$h->{$val}}, $key);
			}
			for my $j (0..4) {
				$key = $id . ':' . 'v' . ($j+1);
				$val = join(',', sort $t->[0][$j],$t->[1][$j],$t->[2][$j],$t->[3][$j],$t->[4][$j]);;
				$h->{$val} ||= [];
				push(@{$h->{$val}}, $key);
			}

			$key = "$id:df";
			$val = join(',', sort $t->[0][0],$t->[1][1],$t->[2][2],$t->[3][3],$t->[4][4]);
			push(@{$h->{$val}}, $key);
			
			$key = "$id:db";
			$val = join(',', sort $t->[0][4],$t->[1][3],$t->[2][2],$t->[3][1],$t->[4][0]);
			push(@{$h->{$val}}, $key);

			$t = [];
		} else {
			chomp($line);
			push(@$t, [split(' ', $line)]);
		}
	}
	close($fh);

	open($fh, '>'. "${in}.perl") or die;
	print $fh Data::Dumper->Dump([$h],['h']);
	close($fh);
}

sub smartmatch
{
	my (%draw, %bingo);
	@draw{split(',', $_[0])} = 1;
	@bingo{split(',', $_[1])} = 1;
	for my $i (keys %bingo) {
		next if ($i !~ /^\d+$/);
		return 0 if (!exists $draw{$i});
	}
	return 1;
}

for my $d (@draw) {
	print "draw = $d\n";
	my $winners = [];
	for my $i (keys %$h) {
		if (smartmatch($d, $i)) {
			push(@$winners, @{$h->{$i}});
		}
	}
	### Done
	print Data::Dumper->Dump([$winners], ['Winners']);
}
