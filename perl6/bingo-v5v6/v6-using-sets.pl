#!/usr/bin/env perl6

my %drawings = (
	1 => set("5", "27", "27", "46", "55", "67"), 
	2 => set("14", "23", "23", "32", "47", "62"),
	3 => set("39", "45", "44", "42", "35"),
	4 => set("69", "49", "1", "26", "10"),
	5 => set("74", "61", "68", "73", "69"),
);

my %winners;

### Parse Block
{
 my @lines = 'bingo.txt'.IO.lines;
 my ($index, $line_count, $player, $board, @t) = (0, @lines.elems);

 while ($index < $line_count) {
  my $line = @lines[$index++];
  next if ($line ~~ /^\s*$/);
  $line = $line.trim;
  if ($line ~~ /Player \: (.*)/) {
   $player = $0.trim;
   my $tmp = @lines[$index++];
   if ($tmp ~~ /Board \: (.*)/) {
    $board = $0.trim;
   }
   my $id = "{$board}:{$player}";

   # We need to examine 5 horizontal, 5 vertical, two diagonals (forward and backward) rows
   my %in = (
    "h1" => @t[0],
    "h2" => @t[1],
    "h3" => @t[2][0,1,3,4],
    "h4" => @t[3],
    "h5" => @t[4],
   
    "v1" => [ @t[0][0],@t[1][0],@t[2][0],@t[3][0],@t[4][0] ],
    "v2" => [ @t[0][1],@t[1][1],@t[2][1],@t[3][1],@t[4][1] ],
    "v3" => [ @t[0][2],@t[1][2],@t[3][2],@t[4][2] ],
    "v4" => [ @t[0][3],@t[1][3],@t[2][2],@t[3][3],@t[4][3] ],
    "v5" => [ @t[0][4],@t[1][4],@t[2][3],@t[3][4],@t[4][4] ],

    "df" => [ @t[0][0],@t[1][1],@t[3][3],@t[4][4] ],
    "db" => [ @t[0][4],@t[1][3],@t[3][1],@t[4][0] ],
   );
   
   my $all = set(|@t[0],|@t[1],|@t[2][0,1,3,4],|@t[3],|@t[4]); ### Unique elements of Bingo card

  for %drawings.keys -> $draw {
   # IF bingo card has less than 4 numbers from the drawing, no need to go further
   if (%drawings{$draw} (&) $all).elems >= 4 {
    for %in.kv -> $k, $v {
     %winners{$draw}.push("{$id}:{$k}") if set(@(%in{$k})) (<=) %drawings{$draw};
    }
   }
  }
   @t = ();
  } else {
   @t.push([ $line.split(' ') ]);
  }
 }
}

%winners.say;
