#!/usr/bin/env perl

use strict;
use warnings;

use Data::Table;
use Date::Calc qw(Delta_Days Add_Delta_Days);
use CGI;
use Data::Dumper;

use Utils;

my $q = CGI->new;

my $D = $q->param('D');
my $P = $q->param('P');
my $deposits = $q->param('deposits');

my $adjust = $q->param('adjust') // 1;

my $dt = Data::Table::fromFile($deposits);
$dt->addCol(0, 'n');
$dt->colsMap(sub { $_->[-1] = Delta_Days(split("-", $_->[0]), split("-", $D)) } );

my $Sp = 0;
$dt->addCol(0, 'Sp');
$dt->colsMap(sub { $_->[-1] = ($Sp += $_->[1]); } );

my $Spn = 0;
$dt->addCol(0, 'Spn');
$dt->colsMap(sub { $_->[-1] = ($Spn += $_->[1] * $_->[2]); } );

my $first_row = $dt->rowHashRef(0);
my $last_row = $dt->rowHashRef($dt->lastRow);
my $interest = $P - $last_row->{Sp};

my $dsr = $interest/$last_row->{Spn};

my $dsr_adjust = $dsr * $adjust;

print <<EOF;
I (interest enarned) = $interest
DSR (daily simple rate) = $dsr (${\(sprintf("APR %.4f", 365*100*$dsr))})
equivalent compounded rate (ajusted per input) = $dsr_adjust (${\(sprintf("APR %.4f", 365*100*$dsr_adjust))})

EOF

$dt->addCol(0, 'si');
$dt->colsMap(sub { $_->[-1] = sprintf("%.2f", $_->[1] * $_->[2] * $dsr) });
my $Csi = 0;
$dt->addCol(0, 'Csi');
$dt->colsMap(sub { $_->[-1] = sprintf("%.2f", ($Csi += $_->[1] * $_->[2] * $dsr)) });

$dt->addCol(0, 'ci');
$dt->colsMap(sub { $_->[-1] = sprintf("%.2f", $_->[1] * (1 + $dsr)**$_->[2] - $_->[1]) });
my $Cci = 0;
$dt->addCol(0, 'Cci');
$dt->colsMap(sub { $_->[-1] = sprintf("%.2f", ($Cci += $_->[-2])) });

$dt->addCol(0, 'ci_adjust');
$dt->colsMap(sub { $_->[-1] = sprintf("%.2f", $_->[1] * (1 + $dsr_adjust)**$_->[2] - $_->[1]) });
my $Cci_adjust = 0;
$dt->addCol(0, 'Cci_adjust');
$dt->colsMap(sub { $_->[-1] = sprintf("%.2f", ($Cci_adjust += $_->[-2])) });

my $last_ac_value = 0;
my $last_ac_date = $first_row->{d};

$dt->addCol(0, 'ac_value');
$dt->colsMap(sub {
	$_->[-1] = sprintf("%.2f", ($last_ac_value = $_->[1] + $last_ac_value * (1 + $dsr_adjust)**(Delta_Days(split('-', $last_ac_date), split('-', $_->[0])))));
	$last_ac_date = $_->[0];
});

$last_row = $dt->rowHashRef($dt->lastRow);
$dt->addRow({d => $D, ac_value => sprintf("%.2f", $last_ac_value * (1 + $dsr_adjust)**(Delta_Days(split("-", $last_ac_date), split("-", $D)))),});

print Data::Table::normalize_column_widths($dt)->csv(1, {delimiter => '|'});

my @date_list = ();
my $count = 0;
while(1) {
	my @a = Add_Delta_Days(split('-', $first_row->{d}), $count);
	push(@date_list, my $d = sprintf("%d-%02d-%02d", @a));
	#print "$d\n";

	last if ($d eq $D);
	$count++;
}

my $final = Data::Table->new(undef, undef, 0);
$final->addCol([@date_list], 'Date');

# Data::Table::INNER_JOIN Data::Table::LEFT_JOIN Data::Table::RIGHT_JOIN Data::Table::FULL_JOIN

print "===\n";
<STDIN>;

my $tab = $final->join($dt, Data::Table::FULL_JOIN, ['Date'], ['d'], {renameCol => 1});
$tab -> reorder([qw/Date p ac_value/], {keepRest => 0});
$tab -> sort('Date', 1, 0);


$first_row = $tab->rowHashRef(0);

$last_ac_value = $first_row->{ac_value};
$last_ac_date = $first_row->{d};

$tab->colsMap(sub {
	if (!defined($_->[-1])) {
		$_->[-1] = sprintf("%.2f", ($last_ac_value = $last_ac_value * (1 + $dsr_adjust)**(Delta_Days(split('-', $last_ac_date), split('-', $_->[0])))));
	} else {
		$last_ac_value = $_->[-1];
	}
	$last_ac_date = $_->[0];
});

print Data::Table::normalize_column_widths($tab)->csv(1, {delimiter => '|'});

<STDIN>;

use GD::Graph::points;

my $graph = GD::Graph::points->new(900, 600);
$graph->set( 
	bgclr		=> 'white',
	transparent	=> 0,
	x_label		=> 'Time',
	x_label_skip 	=> 30,
	x_labels_vertical => 1,
	x_label_position => 0.5,
	y_label		=> 'Value',
	title		=> 'Account Value Over Time',
	y_max_value	=> 500,
	y_min_value	=> 0,
	y_tick_number	=> 10,
	y_label_skip	=> 1,
) or die $graph->error;

my $gd = $graph->plot($tab->colRefs([0,2]));
open(my $img, '>', 'account.png') or die $!;
binmode($img);
print $img $gd->png;
close($img);

print "Graph of 'account value over time' is in 'account.png'\n";
