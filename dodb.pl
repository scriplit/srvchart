use Modern::Perl qw/2013/;
use lib '.';
use SrvChart::DB;
use DateTime;

sub main {
	my $dbh = SrvChart::DB::open();
	my @v   = qw/
	  1 SysA Type1 112
	  1 SysA Type2 223
	  1 SysA Type3 317
	  1 SysB Type4 412
	  1 SysB Type5 523
	  1 SysB Type6 617
	  1 SysC Type7 712
	  1 SysC Type8 823
	  1 SysC Type9 917
	  2 SysA Type1 142
	  2 SysA Type2 253
	  2 SysA Type3 367
	  2 SysB Type4 472
	  2 SysB Type5 583
	  2 SysB Type6 697
	  2 SysC Type7 712
	  2 SysC Type8 923
	  2 SysC Type9 999
	  3 SysA Type3 332
	  3 SysA Type2 223
	  3 SysA Type3 337
	  3 SysB Type4 432
	  3 SysB Type5 523
	  3 SysB Type6 637
	  3 SysC Type7 732
	  3 SysC Type8 823
	  3 SysC Type9 937
	  4 SysA Type1 144
	  4 SysA Type4 453
	  4 SysA Type3 367
	  4 SysB Type4 474
	  4 SysB Type5 583
	  4 SysB Type6 697
	  4 SysC Type7 714
	  4 SysC Type8 943
	  4 SysC Type9 999
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