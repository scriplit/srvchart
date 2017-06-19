use Modern::Perl qw/2013/;
use lib '.';
use SrvChart::DB;
use DateTime;

sub main {
	my $dbh = SrvChart::DB::open();
	my @v   = qw/
	  1 SysA Type1 100
	  1 SysA Type2 101
	  1 SysA Type3 102
	  1 SysB Type4 103
	  1 SysB Type5 104
	  1 SysB Type6 105
	  1 SysC Type7 106
	  1 SysC Type8 107
	  1 SysC Type9 108
	  2 SysA Type1 109
	  2 SysA Type2 110
	  2 SysA Type3 111
	  2 SysB Type4 112
	  2 SysB Type5 113
	  2 SysB Type6 114
	  2 SysC Type7 115
	  2 SysC Type8 116
	  2 SysC Type9 117
	  3 SysA Type3 118
	  3 SysA Type2 119
	  3 SysA Type3 120
	  3 SysB Type4 121
	  3 SysB Type5 122
	  3 SysB Type6 123
	  3 SysC Type7 124
	  3 SysC Type8 125
	  3 SysC Type9 126
	  4 SysA Type1 127
	  4 SysA Type4 128
	  4 SysA Type3 129
	  4 SysB Type4 130
	  4 SysB Type5 131
	  4 SysB Type6 132
	  4 SysC Type7 133
	  4 SysC Type8 134
	  4 SysC Type9 135
	  /;
	my $s = $dbh->prepare("INSERT INTO COUNTS VALUES(NULL, ?, ?, ?, ?);");
	my $n = 0;

	while ( $n < @v ) { 
		my $ts = DateTime->from_epoch( epoch =>(time - (16400 * $n*$v[ $n++ ])));
		$s->execute( $ts, $v[ $n++ ], $v[ $n++ ], $v[ $n++ ] );
	}

	$dbh->disconnect();
}



main();