#!/usr/bin/env perl

use strict;
use warnings;

my $count;
my $result;

# retuen index of least element of an array
sub min
{
	my $result = 0;
	my $index = 0;
	my $least = shift @_;

	for my $i (@_) {
		$index++;
		$count++;	### Keep track of comparisons
		if ($i < $least) {
			$result = $index;		
			$least = $i;
		}
	}
	return $result;
}

sub merge_ordered
{
	my @in = @_;
	my $result = [];

	while (@in) {
		my @current = map { $_->[0] } @in;
		my $index = min(@current);
		push($result, $current[$index]);
		shift $in[$index];
		splice(@in, $index, 1) if (0 == @{$in[$index]});
	}
	return $result;
}

### Consider input as degenerate sorted lists of one element each and then merge
sub my_order_0
{
	my $in = shift;
	if (1 == @$in) {
		return $in;
	}
	return merge_ordered(map { [$_] } @$in);
}

### Divide input into first and rest, sort rest and merge
sub my_order_1
{
	my $in = shift;
	if (1 == @$in) {
		return $in;
	}
	my $first = shift $in;
	return merge_ordered([$first], my_order_1($in));
}


### Divide input into two equal sized, sort each and merge 
sub my_order_2
{
	my $in = shift;
	my $members = @$in;
	if (1 == $members) {
		return $in;
	}
	return merge_ordered(my_order_2([@$in[0..($members/2)-1]]), my_order_2([@$in[($members/2)..($members-1)]]));
}

### Divide input into three equal sized, sort each and merge 
sub my_order_3
{
	my $in = shift;
	my $members = @$in;
	if (1 == $members) {
		return $in;
	}
	if (2 == $members) {
		return merge_ordered(
			my_order_3([@$in[0..($members/2)-1]]),
			my_order_3([@$in[($members/2)..($members-1)]])
		);
	}
	return merge_ordered(
		my_order_3([@$in[(2*$members/3) .. $members-1]]),
		my_order_3([@$in[($members/3)..((2*$members/3)-1)]]), 
		my_order_3([@$in[0..($members/3)-1]]), 
	);
}

my $in0 = [@ARGV];
$count=0;
$result = my_order_0($in0);
print join(',', @$result), "\n";
print "0) count = $count\n";

my $in1 = [@ARGV];
$count=0;
$result = my_order_1($in1);
print join(',', @$result), "\n";
print "1) count = $count\n";

my $in2 = [@ARGV];
$count=0;
$result = my_order_2($in2);
print join(',', @$result), "\n";
print "2) count = $count\n";

my $in3 = [@ARGV];
$count=0;
$result = my_order_3($in3);
print join(',', @$result), "\n";
print "3) count = $count\n";
