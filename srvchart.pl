use Modern::Perl qw/2013/;
use SrvChart::DB;
use Dancer2;
use Try::Tiny;

get '/' => sub {
	send_file 'index.html';
};

get '/data/sum/:id?' => sub {
	my $sys  = param('id');
	my $data = get_data_from_db($sys);
	my $json;
	if ( defined $data ) {
		$json = single_chart( $sys, $data );
	}
	return $json;
};

sub single_chart {
	my $sys       = shift;
	my $data      = shift;
	my @labels    = ();
	my @chartData = ();
	for my $e (@$data) {
		push @labels,    $e->[0];
		push @chartData, $e->[1];
	}
	my $json = encode_json(
		{
			labels   => \@labels,
			datasets => [
				{
					label => $sys,
					data  => \@chartData
				}
			  ]

		}
	);
	return $json;
}

sub get_data_from_db {
	my $sys = shift;
	if ( $sys !~ /^\w+$/ ) {
		print STDERR "Unsafe SQL: sys = '$sys'\n";
		return undef;
	}
	my $dbh = SrvChart::DB::open();
	my $q =
	  "select ts, sum(count) from counts where system = '$sys' group by ts;";
	my ( $s, $r );
	try {
		$s = $dbh->prepare($q);
		$s->execute();
		$r = $s->fetchall_arrayref();
	}
	catch {
		print STDERR $_;
		return undef;
	};
	$dbh->disconnect();
	return $r;
}

start;
