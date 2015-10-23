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
  $draws->{$game} = $h; 
}

my $winners;

### Parse Block
{
 my @lines = split("\n", do { local(@ARGV, $/) = "bingo.txt"; <> });
 my $t = [];
 my ($player, $board);

 my $index = 0;
 my $lines_count = @lines;
 while ($index < $lines_count) {
  my $line = $lines[$index++];
  next if ($line =~ /^\s*$/);
  chomp($line);
  if ($line =~ /Player:\s*(.*)\s*$/) {
   $player = $1;
   my $tmp = $lines[$index++];
   if ($tmp =~ /Board:\s*(.*)\s*$/) {
    $board = $1;
   }
   my $id = "$board:$player";

   # Examine 5 horizontal, 5 vertical, two diagonals (forward and backward) rows
   my %in = ( 
    "h1" => $t->[0],
    "h2" => $t->[1],
    "h3" => [@{$t->[2]}[0,1,3,4]],
    "h4" => $t->[3],
    "h5" => $t->[4],
   
    "v1" => [ $t->[0][0],$t->[1][0],$t->[2][0],$t->[3][0],$t->[4][0] ],
    "v2" => [ $t->[0][1],$t->[1][1],$t->[2][1],$t->[3][1],$t->[4][1] ],
    "v3" => [ $t->[0][2],$t->[1][2],$t->[3][2],$t->[4][2] ],
    "v4" => [ $t->[0][3],$t->[1][3],$t->[2][2],$t->[3][3],$t->[4][3] ],
    "v5" => [ $t->[0][4],$t->[1][4],$t->[2][3],$t->[3][4],$t->[4][4] ],

    "df" => [ $t->[0][0],$t->[1][1],$t->[3][3],$t->[4][4] ],
    "db" => [ $t->[0][4],$t->[1][3],$t->[3][1],$t->[4][0] ],
   );

   # Keep track of all numbers on a bingo card, helps in eliminating examning each of 12 rows
   my @all = (@{$t->[0]}, @{$t->[1]}, @{$t->[2]}[0,1,3,4], @{$t->[3]}, @{$t->[4]});

   for my $g (keys %$draws) {
    my $draw = $draws->{$g};
    # IF bingo card has less than 4 numbers from the drawing, no need to go further
    if ((grep { defined } @{$draws->{$g}}{@all}) >= 4) {
     for my $k (keys %in) {
      push(@{$winners->{$g}}, "${id}:${k}") if (@{$in{$k}} == grep { defined } @{$draws->{$g}}{@{$in{$k}}});
     }
    }
   }

   $t = [];
  } else {
   push(@$t, [ split(' ', $line) ]);
  }
 }
}

print Data::Dumper->Dump([$winners], ['Winners']);
