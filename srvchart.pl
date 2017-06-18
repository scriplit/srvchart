use Modern::Perl qw/2013/;
use SrvChart::DB;
use Dancer2;
use Try::Tiny;

get '/' => sub {
	send_file 'index.html';
};

get '/data/sum/:id?' => sub {
	my $json;
	my $dbh = SrvChart::DB::open();
	my $sys = param('id');
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
		return {};
	};
	my @labels    = ();
	my @chartData = ();
	for my $e (@$r) {
		push @labels,    $e->[0];
		push @chartData, $e->[1];
	}
	$json = encode_json(
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
	$dbh->disconnect();
	return $json;
};

start;
