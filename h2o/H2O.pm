package H2O;

use strict;
use warnings;

use Data::Table;
use Carp qw(croak);
use YAML;
#use Smart::Comments;

our $VERSION = '1.00';

sub csv2hashref
{
	my $in = shift;

	my $href = {};
	my $data = Data::Table::fromCSV($in)->{data};

	for my $i (@{$data}) {
		$href->{$i->[0]} = $i->[1];
	}
	return $href;
}

sub h2o
{
	my $in = shift;
	my $all_parents = shift // 0;

	my $org = {};

	my %known = ();

	for my $child (keys %{$in}) {
		### Org: $org
		my $parent = $in->{$child};
		### Node: "Child $child, Parent $parent"
		if ($known{$parent}) {
			if ($known{$child}) {
				$known{$parent}{$child} = $known{$child};
				if (!$all_parents) {
					delete $org->{$child};
				}
			} else {
				$known{$parent}{$child} = {};
				$known{$child} = $known{$parent}{$child};
				if ($all_parents) {
					$org->{$parent} = $known{$parent};
				}
			}
		} elsif ($known{$child}) {
			$org->{$parent}{$child} = $known{$child};
			$known{$parent} = $org->{$parent};
			if (!$all_parents) {
				delete $org->{$child};
			}
		} else {
			$org->{$parent}{$child} = {};
			$known{$child} = $org->{$parent}{$child};
			$known{$parent} = $org->{$parent};
		}
	}
	return $org;
}

1;
