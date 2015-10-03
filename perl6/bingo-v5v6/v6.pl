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

sub examine($id, %all, %in)
{
 my @all = keys %all;

 for %draws.keys -> $g {
  # IF bingo card has less than 4 numbers from the drawing, no need to go further
  next if (%draws{$g}{@all}.grep({$_.defined}).elems < 4);
  for %in.kv -> $k, $v {
   %winners{$g}.push("{$id}:{$k}") if (%in{$k}.elems == %draws{$g}{@(%in{$k})}.grep({$_.defined}).elems);
  }
 }
}

### Parse Block
{
 my $fh = open "bingo.txt", :r;
 my @t = ();
 my %all = ();
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

   # Examine 5 horizontal, 5 vertical, two diagonals (forward and backward) rows
   examine($id, %all, {"h1" => @t[0],
    "h2" => @t[1],
    "h3" => @t[2],
    "h4" => @t[3],
    "h5" => @t[4],
   
    "v1" => [ @t[0][0],@t[1][0],@t[2][0],@t[3][0],@t[4][0] ],
    "v2" => [ @t[0][1],@t[1][1],@t[2][1],@t[3][1],@t[4][1] ],
    "v3" => [ @t[0][2],@t[1][2],@t[3][2],@t[4][2] ],
    "v4" => [ @t[0][3],@t[1][3],@t[2][2],@t[3][3],@t[4][3] ],
    "v5" => [ @t[0][4],@t[1][4],@t[2][3],@t[3][4],@t[4][4] ],

    "df" => [ @t[0][0],@t[1][1],@t[3][3],@t[4][4] ],
    "db" => [ @t[0][4],@t[1][3],@t[3][1],@t[4][0] ]});

   @t = ();
   %all = ();
  } else {
   my @a = $line.split(' ').grep(/\d/);
   push(@t, [@a]);
   %all{@a} = @a; # Keep track of all numbers on a bingo card, 
                  # Helps in eliminating examning each of 12 rows
  }
 }
 $fh.close;
}

%winners.say;
