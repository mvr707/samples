Perl challenge by Tony Gasparovic

THE CHALLENGE:

  You are given a data file containing 1000 bingo cards. Determine which bingo cards have won a prize.

DETAILS:


  Winning bingo cards are those that match all 5 drawing numbers in a row, vertically, horizontally or diagonally. A free space is included in the middle of the
  card and is marked wth two '**' asterisks. The last two lines contain the bingo card number and the players name.

  Example bingo card:

  14 23 43 52 65
   3 28 37 58 71
  13 26 ** 47 70
  10 19 42 46 69
  15 17 45 53 75
  Player:Sue Green
  Board:1000

  
  When you detect a card as a winner, print it to the screen and add an extra line at the bottom describing what line matched. 

  Example: The following drawing numbers: 14,52,65,23,43. The first horizontal line matched all 5 numbers of the following bingo card. See the bold text. 

  14 23 43 52 65
   3 28 37 58 71
  13 26 ** 47 70
  10 19 42 46 69
  15 17 45 53 75
  Player:Sue Green
  Board:1000
  Horizontal line 1  



  DRAWING NUMBERS:

  Find the winners for all 5 drawings. Scan the same bingo cards for all drawings. 

  drawing 1 = 5,27,46,55,67
  drawing 2 = 14,23,32,47,62
  drawing 3 = 39,45,44,42,35
  drawing 4 = 69,49,1,26,10
  drawing 5 = 74,61,68,73,69



  DATA FILE:

  bingo.txt


  DATA FILE WITH ANSWERS:

  answers.txt



