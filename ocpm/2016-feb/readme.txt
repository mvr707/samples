THE CHALLENGE:

  Match the scrambled words and print them in numeric order.

DETAILS:

  You are given two data files: 

        Numbers converted to english text (0 - 1000). One word count per line random order: wordcounts.txt

        Same word counts but scrambled: scrambled.txt


        Write a Perl program that prints the word counts in ascending numeric order with its matching scrambled word on a single line.
	If there are multiple scrambled words, they be presented with '|' as seperator

        CPAN is your friend: CPAN


        Column1 = Digit count. You will need to convert text to numeric numbers. 
        Column2 = correctly spelled word count. From wordcounts.txt file
        Column3 = scrambled word count (s) that matches column2. From scrambled.txt file.


        Example Output - fields separated by comma
        ________________________________

        0,zero,oezr
        1,one,eno
        2,two,otw
        3,three,rehet
        4,four,fuor
        5,five,vfie
        6,six,xsi
        7,seven,nesve
        8,eight,higte
        9,nine,enni
        10,ten,tne
	.
	.
	.
	69,sixty-nine,nienitsy-x|isei-nyxtn
	.
	96,ninety-six,nienitsy-x|isei-nyxtn
	.
	.
	.
        1000,one thousand,enou nodtsha

SOLUTION:

% time perl unscramble.p5 > out5

real	0m0.040s
user	0m0.040s
sys	0m0.000s

% time perl6 unscramble.p6 > out6

real	0m3.169s
user	0m3.100s
sys	0m0.068s

% diff go.out5 go.out6
% 

